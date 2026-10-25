@@directive("'use client';")

@val @scope("navigator") external browserLanguage: string = "language"

module VideoClientMemo = {
  let make = React.memo(VideoPageClient.make)
}

@react.component
let make = () => {
  let route = Location.usePath()->Option.map(Routes.parse)

  React.useEffect(() => {
    if route == Some(Root) {
      Location.replace(`/${Routes.localeOf(browserLanguage)}`)
    }
    None
  }, [route])

  switch route {
  | None | Some(Root) => React.null
  | Some(Home(params)) => <HomePageClient params />
  | Some(Live(params)) => <LiveClient params />
  | Some(LivePage(params)) => <LivePageClient params />
  | Some(Video(params)) => <VideoClientMemo params />
  | Some(Category(params)) => <CategoryPageClient params />
  }
}
