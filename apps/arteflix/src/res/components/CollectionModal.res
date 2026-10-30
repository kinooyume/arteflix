open ArteContract
open Emotion

module Style = {
  let body = `
    --side-padding: clamp(20px, 5%, 48px);
    display: flex;
    flex-direction: column;
    gap: 32px;
    padding-bottom: 48px;
  `->rawCss

  let info = `
    padding: 0 var(--side-padding);
  `->rawCss
}

let heroItem = (data: ArteData.t) =>
  data.zones
  ->Array.find(z => z.displayOptions.template == #"single-collectionContent")
  ->Option.flatMap(z => z.content.data->Array.get(0))

let renderZone = (zone: ArteZone.t, ~lang) =>
  switch zone.displayOptions.template {
  | #"single-collectionContent" => React.null
  | #"tableview-playnext" | #"verticalFirstHighlighted-landscape" =>
    <ZoneEpisodeBlock key=zone.id zone id="" lang />
  | _ => <Zone key=zone.id zone />
  }

type props_ = {
  params: Params.collection,
  background: option<string>,
}

@react.component(: props_)
let make = (~params, ~background) => {
  let {data} = Swr.useSWR(ArteApiProxy.Urls.collection(params), ClientFetcher.resolvedFetcher)
  let item = data->Option.flatMap(heroItem)

  let close = () =>
    switch background {
    | Some(_) => Location.back()
    | None => Location.replace(`/${params.lang}`)
    }

  <InfoModal label={item->Option.map(i => i.title)->Option.getOr("")} onClose=close>
    {switch (data, item) {
    | (Some(data), Some(item)) =>
      <div className={Style.body}>
        <InfoModalHero
          imageSrc={ArteImage.resolveUrl(item.mainImage.url, "1920x1080")}
          imageAlt={item.mainImage.caption->Option.getOr(item.title)}
          title=item.title
          playHref=Some(item.url)
          trailer={Trailer.url(item)}
        />
        <div className={Style.info}>
          <CollectionInfo.Main
            subtitle=item.subtitle
            description={item.fullDescription->Option.orElse(item.shortDescription)}
          />
        </div>
        {data.zones->Array.map(zone => renderZone(zone, ~lang=params.lang))->React.array}
      </div>
    | _ => <RowSkeleton />
    }}
  </InfoModal>
}
