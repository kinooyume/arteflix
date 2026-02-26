@@directive("'use client';")

open ArteContract
open ArteApiProxy
open ClientFetcher

@val @module("swr")
external useSWRNullable: (
  Js.Nullable.t<string>,
  SwrCommon.fetcher1<string, 'data>,
) => Swr.swrResponse<'data> = "default"

let extractSeriesId: string => option<string> = %raw(`
  function(url) {
    var matches = url.match(/\/(RC-\d+)\//g);
    if (matches && matches.length >= 2) return matches[0].replace(/\//g, '');
    return undefined;
  }
`)

// let defaultOptions: VideoJs.playerOptions = {
//   controls: true,
//   preload: #auto,
//   fluid: false,
// }
//
// let makePlayer = (~playerConfig: ArtePlayerConfig.t) => {
//   switch playerConfig.attributes.streams->Array.get(0) {
//   | Some(stream) => {
//       let options = switch playerConfig.attributes.autoplay {
//       | true => {...defaultOptions, autoplay: #any}
//       | false => defaultOptions
//       }
//       <Player url={stream.url} options />
//     }
//   | None => <p> {"No Stream"->React.string} </p> // TODO: Handler Error no Stream
//   }
// }
//
//

let emptySingleProgramContent: ArteZone.t = {
  id: "",
  code: "",
  slug: None,
  metadata: None,
  title: "",
  description: None,
  content: {
    data: [],
    pagination: None,
  },
  link: None,
  displayOptions: {
    template: #"single-programContent",
    showZoneTitle: false,
    showItemTitle: false,
  },
  authenticatedContent: None,
  groupedZonesName: None,
  displayTeaserGenre: Some(false),
}

let buildEpisodeGroups = (
  collectionData: option<ArteData.t>,
  programData: option<ArteData.t>,
  currentId: string,
  ~lang: string,
) => {
  switch collectionData {
  | Some(collection) =>
    let groups =
      collection.zones
      ->Array.filter(z => {
        let items = z.content.data
        items->Array.length > 0 &&
          items
          ->Array.get(0)
          ->Option.map(i => !i.kind.isCollection)
          ->Option.getOr(false) &&
          z.displayOptions.template == #"horizontal-landscape"
      })
      ->Array.map((z): NetflixMode.episodeGroup => {
        season: z.title,
        episodes: z.content.data->Array.map((item): NetflixMode.episode => {
          title: item.title,
          subtitle: item.subtitle,
          href: item.url,
          selected: item.id == currentId,
          programId: ArteUtils.extractProgramId(item, ~lang),
        }),
      })
    if groups->Array.length > 0 {
      Some(groups)
    } else {
      None
    }
  | None => None
  }->Option.getOr(
    switch programData {
    | Some(arteData) =>
      arteData.zones
      ->Array.find(z => {
        let t = z.displayOptions.template
        t == #"tableview-playnext" || t == #"verticalFirstHighlighted-landscape"
      })
      ->Option.map(z => [
        (
          {
            season: z.title,
            episodes: z.content.data->Array.map((item): NetflixMode.episode => {
              title: item.title,
              subtitle: item.subtitle,
              href: item.url,
              selected: item.id == currentId,
              programId: ArteUtils.extractProgramId(item, ~lang),
            }),
          }: NetflixMode.episodeGroup
        ),
      ])
      ->Option.getOr([])
    | None => []
    },
  )
}

let replaceUrl: string => unit = %raw(`function(url) { window.history.replaceState(null, "", url) }`)

module VideoPageZones = {
  type props_ = {
    params: Params.program,
    arteData: ArteData.t,
    episodes: array<NetflixMode.episodeGroup>,
  }

  @react.component(: props_)
  let make = (~params, ~arteData, ~episodes) => {
    let (currentProgramId, setCurrentProgramId) = React.useState(() => params.id)

    let currentId = `${currentProgramId}_${params.lang}`
    let remappedEpisodes =
      episodes->Array.map((g): NetflixMode.episodeGroup => {
        ...g,
        episodes: g.episodes->Array.map(
          (e): NetflixMode.episode => {...e, selected: e.programId ++ "_" ++ params.lang == currentId},
        ),
      })
    let episodes = if remappedEpisodes->Array.length > 0 {
      Some(remappedEpisodes)
    } else {
      None
    }

    let onEpisodeSelectHandler = React.useCallback0((ep: NetflixMode.episode) => {
      setCurrentProgramId(_ => ep.programId)
      replaceUrl(ep.href)
      Webapi.Dom.window->Webapi.Dom.Window.scrollToWithOptions({"top": 0.0, "left": 0.0, "behavior": "smooth"})
    })

    let videoZones = arteData.zones->Array.filter(z =>
      z.displayOptions.template == #"single-programContent"
    )
    let otherZones = arteData.zones->Array.filter(z =>
      z.displayOptions.template != #"single-programContent"
    )
    let sortedZones = Array.concat(videoZones, otherZones)
    let hasPlayer = videoZones->Array.some(z => z.content.data->Array.length > 0)
    let onEpisodeSelect = if hasPlayer { Some(onEpisodeSelectHandler) } else { None }

    Console.log3(
      "[VideoPage] Zones:",
      sortedZones->Array.length,
      sortedZones->Array.mapWithIndex((z, i) =>
        `${(i + 1)->Int.toString}. ${(z.displayOptions.template :> string)} - ${z.title}`
      ),
    )
    <FadeIn>
      <div>
        {sortedZones
        ->Array.mapWithIndex((zone, index) =>
          <Lazyload key={index->Int.toString} once=true height=300 offset=200>
            <ZoneVideo
              id={currentProgramId}
              key={index->Int.toString}
              lang={params.lang}
              zone
              metadata={arteData.metadata}
              parent={arteData.parent}
              ?episodes
              onEpisodeSelect=?onEpisodeSelect
            />
          </Lazyload>
        )
        ->React.array}
      </div>
    </FadeIn>
  }
}

@react.component
let make = (~params: Params.program) => {
  // program
  let {data, error} = if params.id->String.includes("-A") {
    Swr.useSWR_config(
      params->Urls.program,
      fetcher(validateArteData, ...),
      Swr.swrConfiguration(
        ~fallbackData=(
          {
            zones: [emptySingleProgramContent],
            metadata: None,
            parent: None,
          }: ArteData.t
        ),
        (),
      )
    )
    // collection
  } else if params.id->String.includes("RC-") {
    Swr.useSWR(params->Urls.collection, fetcher(validateArteData, ...))
    // category
  } else if params.id->String.includes("-A") {
    Swr.useSWR(params->Urls.program, fetcher(validateArteData, ...))
  } else {
    let slug = switch params.title {
    | Some(title) => `videos/${params.id}/${title}`
    | None => `videos/${params.id}`
    }

    let categoryParams: ArteContract.Params.category = {lang: params.lang, slug}
    Swr.useSWR(categoryParams->Urls.category, fetcher(validateArteData, ...))
  }

  let seriesCollectionId =
    data
    ->Option.flatMap(d =>
      d.zones->Array.find(z => {
        let t = z.displayOptions.template
        t == #"tableview-playnext" || t == #"verticalFirstHighlighted-landscape"
      })
    )
    ->Option.flatMap(z => z.link)
    ->Option.flatMap(l => l.url)
    ->Option.flatMap(extractSeriesId)

  let collectionUrl =
    seriesCollectionId
    ->Option.map(id => Urls.collection({id, lang: params.lang}))
    ->Js.Nullable.fromOption

  let {data: collectionData} = useSWRNullable(collectionUrl, fetcher(validateArteData, ...))

  <>
    {switch error {
    | Some(err) =>
      Console.error3("[VideoPageClient]", params, err)
      switch err {
      | ClientFetcher.FetchError(e) => <ServerError message={`Fetch error: ${e->Exn.message->Option.getOr("unknown")}`} />
      | ClientFetcher.ParseError(e) => <ServerError message={`Parse error: ${e.message}`} />
      | Exn.Error(e) => <ServerError message={`Error: ${e->Exn.message->Option.getOr("unknown")}`} />
      | _ => <ServerError message="Unknown error" />
      }
    | None => React.null
    }}
    {switch data {
    | Some(arteData) =>
      <VideoPageZones
        key={`${params.id}_${params.lang}`}
        params
        arteData
        episodes={buildEpisodeGroups(collectionData, data, `${params.id}_${params.lang}`, ~lang=params.lang)}
      />
    | None => <PageSkeleton />
    }}
  </>
}
