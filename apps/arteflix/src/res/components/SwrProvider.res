@@directive("'use client';")

@react.component
let make = (~children) => {
  <Swr.SwrConfigProvider
    value={Swr.swrConfiguration(
      ~revalidateOnFocus=false,
      ~revalidateOnReconnect=false,
      ~dedupingInterval=60000,
      (),
    )}>
    children
  </Swr.SwrConfigProvider>
}
