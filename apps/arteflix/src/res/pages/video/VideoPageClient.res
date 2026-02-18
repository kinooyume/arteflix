@@directive("'use client';")

open ArteContract
open ArteApiProxy
open ClientFetcher

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

  <>
    {switch error {
    | Some(err) =>
      switch err {
      | ClientFetcher.FetchError(_) => <ServerError message="A fetch error occur" />
      | ClientFetcher.ParseError(_) => <ServerError message="A parsing error occur" />
      | Exn.Error(_) => <ServerError message="500 Error | Failed to fetch Arte error" />
      | _ => <ServerError message="500 Error | Failed to fetch Arte error" />
      }
    | None => React.null
    }}
    {switch data {
    | Some(arteData) =>
      // Move video player to top, keep API order for the rest
      let videoZones = arteData.zones->Array.filter(z =>
        z.displayOptions.template == #"single-programContent"
      )
      let otherZones = arteData.zones->Array.filter(z =>
        z.displayOptions.template != #"single-programContent"
      )
      let sortedZones = Array.concat(videoZones, otherZones)
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
                id={params.id}
                key={index->Int.toString}
                lang={params.lang}
                zone
                metadata={arteData.metadata}
                parent={arteData.parent}
              />
            </Lazyload>
          )
          ->React.array}
        </div>
      </FadeIn>
    | None => <PageSkeleton />
    }}
  </>
}
