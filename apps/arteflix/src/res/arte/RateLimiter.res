type t = {
  mutable tokens: float,
  mutable lastRefill: float,
  maxTokens: float,
  refillRate: float,
  queue: array<unit => unit>,
  mutable inflight: int,
  maxConcurrent: int,
}

@val external dateNow: unit => float = "Date.now"

let make = (~maxPerSecond=20, ~maxConcurrent=10) => {
  let maxTokens = maxPerSecond->Int.toFloat
  {
    tokens: maxTokens,
    lastRefill: dateNow(),
    maxTokens,
    refillRate: maxTokens,
    queue: [],
    inflight: 0,
    maxConcurrent,
  }
}

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

let acquire = limiter =>
  Promise.make((resolve, _reject) => {
    refill(limiter)
    if limiter.tokens >= 1.0 && limiter.inflight < limiter.maxConcurrent {
      limiter.tokens = limiter.tokens -. 1.0
      limiter.inflight = limiter.inflight + 1
      resolve()
    } else {
      limiter.queue->Array.push(() => resolve())
      let _ = Js.Global.setTimeout(() => {
        refill(limiter)
        drain(limiter)
      }, 50)
    }
  })

let release = limiter => {
  limiter.inflight = limiter.inflight - 1
  refill(limiter)
  drain(limiter)
}

let withLimit = async (limiter, fn) => {
  await acquire(limiter)
  try {
    let result = await fn()
    release(limiter)
    result
  } catch {
  | e => {
      release(limiter)
      raise(e)
    }
  }
}
