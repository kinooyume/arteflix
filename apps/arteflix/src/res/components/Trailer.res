let url = (content: ArteZoneContent.t): PlayerTransition.url =>
  switch content.trailer {
  | Some({id}) =>
    let lang = content.url->Location.langOf->Option.getOr("fr")
    ToFetch(() => TrailerFetcher.fetchStreamUrl(~lang, ~id))
  | None => NoVideo
  }
