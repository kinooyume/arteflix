type priority = High | Medium | Low

type status =
  | Loading
  | Loaded
  | Failed(int)

type entry = {
  url: string,
  priority: priority,
  mutable callbacks: array<unit => unit>,
}

type state = {
  mutable pending: array<entry>,
  mutable active: int,
  mutable cache: Dict.t<status>,
  mutable dispatched: Set.t<string>,
  mutable loadTimers: Dict.t<timeoutId>,
  maxConcurrent: int,
  maxRetries: int,
}

let isClient: unit => bool = %raw(`function() { return typeof window !== "undefined" }`)

let state: ref<option<state>> = ref(None)

let getState = () =>
  switch state.contents {
  | Some(s) => s
  | None =>
    let s = {
      pending: [],
      active: 0,
      cache: Dict.make(),
      dispatched: Set.make(),
      loadTimers: Dict.make(),
      maxConcurrent: 12,
      maxRetries: 3,
    }
    state := Some(s)
    s
  }

let priorityToInt = p =>
  switch p {
  | High => 0
  | Medium => 1
  | Low => 2
  }

let getCached = (url: string): option<status> => {
  let s = getState()
  s.cache->Dict.get(url)
}

let rec flush = () => {
  let s = getState()
  s.pending->Array.sort((a, b) =>
    (priorityToInt(a.priority) - priorityToInt(b.priority))->Int.toFloat
  )

  let continue = ref(true)
  while continue.contents && s.pending->Array.length > 0 {
    let canDispatch = switch s.pending->Array.get(0) {
    | Some({priority: High}) => true
    | Some(_) => s.active < s.maxConcurrent
    | None => false
    }

    if canDispatch {
      switch s.pending->Array.shift {
      | Some(entry) =>
        s.active = s.active + 1
        s.dispatched->Set.add(entry.url)->ignore

        let timerId = setTimeout(() => {
          s.loadTimers->Dict.delete(entry.url)
          failInternal(~url=entry.url)
        }, 30000)
        s.loadTimers->Dict.set(entry.url, timerId)

        entry.callbacks->Array.forEach(cb => cb())
      | None => continue := false
      }
    } else {
      continue := false
    }
  }
}

and failInternal = (~url) => {
  let s = getState()
  let retries = switch s.cache->Dict.get(url) {
  | Some(Failed(n)) => n
  | _ => 0
  }

  switch s.loadTimers->Dict.get(url) {
  | Some(t) =>
    clearTimeout(t)
    s.loadTimers->Dict.delete(url)
  | None => ()
  }

  if s.dispatched->Set.has(url) {
    s.dispatched->Set.delete(url)->ignore
    s.active = Math.Int.max(0, s.active - 1)
  }

  s.cache->Dict.set(url, Failed(retries + 1))
  flush()
}

let complete = (~url) => {
  let s = getState()
  s.cache->Dict.set(url, Loaded)
  if s.dispatched->Set.has(url) {
    s.dispatched->Set.delete(url)->ignore
    s.active = Math.Int.max(0, s.active - 1)
  }

  switch s.loadTimers->Dict.get(url) {
  | Some(t) =>
    clearTimeout(t)
    s.loadTimers->Dict.delete(url)
  | None => ()
  }

  flush()
}

let fail = (~url) => failInternal(~url)

let request = (~url: string, ~priority: priority, ~onReady: unit => unit): (unit => unit) => {
  if !isClient() {
    onReady()
    () => ()
  } else {
    let s = getState()

    switch s.cache->Dict.get(url) {
    | Some(Loaded) =>
      onReady()
      () => ()
    | Some(Loading) =>
      let existingEntry = s.pending->Array.find(e => e.url == url)
      switch existingEntry {
      | Some(entry) =>
        entry.callbacks->Array.push(onReady)
        () => {
          entry.callbacks =
            entry.callbacks->Array.filter(cb => cb !== onReady)
          if entry.callbacks->Array.length == 0 {
            s.pending = s.pending->Array.filter(e => e.url != url)
            s.cache->Dict.delete(url)
          }
        }
      | None =>
        onReady()
        () => ()
      }
    | Some(Failed(n)) if n >= s.maxRetries =>
      () => ()
    | _ =>
      if s.dispatched->Set.has(url) {
        onReady()
        () => ()
      } else {
        let existingEntry = s.pending->Array.find(e => e.url == url)
        switch existingEntry {
        | Some(entry) =>
          entry.callbacks->Array.push(onReady)
          if priorityToInt(priority) < priorityToInt(entry.priority) {
            entry.callbacks = entry.callbacks
            s.pending =
              s.pending->Array.map(e =>
                e.url == url ? {...e, priority} : e
              )
          }
          () => {
            entry.callbacks =
              entry.callbacks->Array.filter(cb => cb !== onReady)
          }
        | None =>
          s.cache->Dict.set(url, Loading)
          let entry = {url, priority, callbacks: [onReady]}
          s.pending->Array.push(entry)
          flush()
          () => {
            entry.callbacks =
              entry.callbacks->Array.filter(cb => cb !== onReady)
            if entry.callbacks->Array.length == 0 {
              if s.dispatched->Set.has(url) {
                s.dispatched->Set.delete(url)->ignore
                s.active = Math.Int.max(0, s.active - 1)
                switch s.loadTimers->Dict.get(url) {
                | Some(t) =>
                  clearTimeout(t)
                  s.loadTimers->Dict.delete(url)
                | None => ()
                }
                flush()
              } else {
                s.pending = s.pending->Array.filter(e => e.url != url)
              }
              s.cache->Dict.delete(url)
            }
          }
        }
      }
    }
  }
}
