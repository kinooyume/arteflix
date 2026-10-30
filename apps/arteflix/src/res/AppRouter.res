@@directive("'use client';")

@val @scope("navigator") external browserLanguage: string = "language"

module VideoClientMemo = {
  let make = React.memo(VideoPageClient.make)
}

let renderPage = (route: Routes.t) =>
  switch route {
  | Root => React.null
  | Home(params) => <HomePageClient params />
  | Live(params) => <LiveClient params />
  | LivePage(params) => <LivePageClient params />
  | Video(params) => <VideoClientMemo params />
  | Category(params) => <CategoryPageClient params />
  }

@react.component
let make = () => {
  let location = Location.useLocation()
  let route = location->Option.map(l => Routes.parse(l.path))

  React.useEffect(() => {
    if route == Some(Root) {
      Location.replace(`/${Routes.localeOf(browserLanguage)}`)
    }
    None
  }, [route])

  switch (location, route) {
  | (Some({play: true}), Some(Video(params))) if Routes.isCollection(params.id) =>
    <PlayFirstEpisode params />
  | (Some({background}), Some(Video(params))) if Routes.isCollection(params.id) =>
    let backgroundRoute = background->Option.getOr(`/${params.lang}`)->Routes.parse
    <>
      {renderPage(backgroundRoute)}
      <CollectionModal params background />
    </>
  | (_, Some(route)) => renderPage(route)
  | (None, _) | (_, None) => React.null
  }
}
