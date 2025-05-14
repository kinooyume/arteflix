// NOTE: C'etait pour le fallback
// de API/HTML
// TODO: Ca va disparaitre

type pageFetchers = {
  home: list<ArteContract.home>,
  direct: list<ArteContract.direct>,
  playerConfig: list<ArteContract.video>,
  video: list<ArteContract.video>,
  collection: list<ArteContract.video>,
  genre: list<ArteContract.video>,
  category: list<ArteContract.category>,
}

// NOTE: Mettre ces lists dans chaque pages
let prodFetchers: pageFetchers = {
  home: list{ArteApi.Fetcher.home},
  direct: list{ArteHtml.source.direct},
  video: list{ArteHtml.source.video},
  collection: list{ArteHtml.source.video},
  playerConfig: list{ArteApi.Fetcher.player},
  genre: list{ArteHtml.source.video},
  category: list{ArteHtml.source.category},
}

exception EndOfFetchers
exception ArteFetchersFailed(array<exn>)

type fetcherResult = Fetched(ArteData.t) | Errors(array<exn>)

type fetcher<'a> = 'a => promise<ArteData.t>

let rec attemptFetchers = async (fetchers: list<fetcher<'a>>, queries: 'a): ArteData.t => {
  switch fetchers {
  | list{} => raise(ArteFetchersFailed([EndOfFetchers]))
  | list{fetcher, ...restFetchers} =>
    switch await fetcher(queries) {
    | arteData => arteData
    | exception err =>
      switch await restFetchers->attemptFetchers(queries) {
      | arteData => arteData
      | exception ArteFetchersFailed(errs) => raise(ArteFetchersFailed([err, ...errs]))
      }
    }
  }
}

// TODO: separate player and video/trailer
// ==> En pause pour fetcher playerConfig + data
type videoRequest = PlayerConfig(ArteContract.video) | Content(ArteContract.video) | Error(exn)

type video = Video | Collection | Genre

type content = {
  type_: video,
  data: videoRequest,
}

open ArteContract
let makeVideoGet = (queries: Params.video) => {
  let fetchers = if queries.id->String.includes("-A") {
    [
      () => prodFetchers.video->attemptFetchers(queries),
      () => prodFetchers.playerConfig->attemptFetchers(queries),
    ]
  } else if queries.id->String.includes("RC-") {
    [
      () => prodFetchers.collection->attemptFetchers(queries),
      () => prodFetchers.playerConfig->attemptFetchers(queries),
    ]
  } else {
    [() => prodFetchers.genre->attemptFetchers(queries)]
  }

  (index, previousData) => {
    switch previousData {
    | None => Js.null // on lance les fetchers: fetchers[index]
    | Some(data) =>
      if index > fetchers->Array.length - 1 {
        Js.null
      } else {
        Js.null // on lance les fetchers: fetchers[index]
      }
    }
  }
}
