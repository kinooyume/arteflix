type limiter = {
  mutable tokens: float,
  mutable lastRefill: float,
  maxTokens: float,
  refillRate: float,
  queue: array<unit => unit>,
  mutable inflight: int,
  maxConcurrent: int,
}

@val external dateNow: unit => float = "Date.now"

let refill = limiter => {
  let now = dateNow()
  let elapsed = (now -. limiter.lastRefill) /. 1000.0
  limiter.tokens = Math.min(limiter.maxTokens, limiter.tokens +. elapsed *. limiter.refillRate)
  limiter.lastRefill = now
}

let rec drain = limiter => {
  switch limiter.queue->Array.shift {
  | Some(resolve) if limiter.tokens >= 1.0 && limiter.inflight < limiter.maxConcurrent => {
      limiter.tokens = limiter.tokens -. 1.0
      limiter.inflight = limiter.inflight + 1
      resolve()
      drain(limiter)
    }
  | Some(resolve) => limiter.queue->Array.unshift(resolve)
  | None => ()
  }
}

let cdnLimiter: limiter = {
  tokens: 100.0,
  lastRefill: 0.0,
  maxTokens: 100.0,
  refillRate: 100.0,
  queue: [],
  inflight: 0,
  maxConcurrent: 30,
}

let acquire = () =>
  Promise.make((resolve, _reject) => {
    refill(cdnLimiter)
    if cdnLimiter.tokens >= 1.0 && cdnLimiter.inflight < cdnLimiter.maxConcurrent {
      cdnLimiter.tokens = cdnLimiter.tokens -. 1.0
      cdnLimiter.inflight = cdnLimiter.inflight + 1
      resolve()
    } else {
      cdnLimiter.queue->Array.push(() => resolve())
      let _ = Js.Global.setTimeout(() => {
        refill(cdnLimiter)
        drain(cdnLimiter)
      }, 50)
    }
  })

let release = () => {
  cdnLimiter.inflight = cdnLimiter.inflight - 1
  refill(cdnLimiter)
  drain(cdnLimiter)
}

let use = (~src) => {
  let (allowed, setAllowed) = React.useState(_ => false)

  React.useEffect(() => {
    setAllowed(_ => false)
    let cancelled = ref(false)
    let acquired = ref(false)
    let _ =
      acquire()->Promise.then(_ => {
        acquired := true
        if !cancelled.contents {
          setAllowed(_ => true)
        } else {
          release()
        }
        Promise.resolve()
      })

    Some(
      () => {
        cancelled := true
      },
    )
  }, [src])

  let onLoad = () => release()
  let onError = () => release()

  (allowed ? Some(src) : None, onLoad, onError)
}
