type moviePreviewProps = {
  img: string,
  href: string,
  ageRestriction: option<string>,
  audios: option<array<string>>,
  url?: PlayerTransition.url,
  description: option<string>,
  linkAlt?: option<LinkAlt.make>, // NOTE: to call Next.link, react-aria mess with button inside tooltip content
  onExit?: unit => unit,
  isVisible?: bool,
}

@react.component(: moviePreviewProps)
let make = React.memo((
  ~href,
  ~img,
  ~ageRestriction,
  ~audios,
  ~description,
  ~url=NoVideo,
  ~linkAlt=None,
  ~isVisible=false,
  ~onExit=_ => (),
) => {
  let meta = []
  switch ageRestriction {
  | Some(restriction) =>
    meta->Array.push(<MaturityRatingTag key="maturity"> restriction </MaturityRatingTag>)
  | None => ()
  }
  switch audios {
  | Some(audios) =>
    switch audios->Array.length > 0 {
    | true =>
      meta->Array.push(
        <React.Fragment key="audios">
          {audios
          ->Array.mapWithIndex((audio, index) =>
            <QualityTag key={`audio-${index->Int.toString}`}> audio </QualityTag>
          )
          ->React.array}
        </React.Fragment>,
      )
    | false => ()
    }
  | None => ()
  }

  open FramerMotion

  <MoviePreviewPresence isVisible>
    <Motion.div
      key={href}
      initial={{width: "218px", height: "123px", margin: "0 0 123px 0"}}
      animate={{width: "323px", height: "403px", margin: "0", transition: {duration: 0.2}}}
      exit={{width: "218px", height: "123px", margin: "0 0 123px 0", transition: {duration: 0.1}}}>
      <Preview key={href}>
        <Motion.div
          key={href ++ "-img"}
          initial={{width: "218px", height: "123px"}}
          animate={{width: "323px", height: "181px", transition: {duration: 0.2}}}
          exit={{width: "218px", height: "123px", transition: {duration: 0.1}}}>
          // <PlayerTransition urlOption=NoVideo>
          // NOTE: probably merge with movieCardImage
          <PreviewImage srcBase=img href />
          // </PlayerTransition>
        </Motion.div>
        <Motion.div
          key={href ++ "-description"}
          initial={{opacity: 0.0, height: "0"}}
          animate={{opacity: 1.0, height: "222px", transition: {duration: 0.2}}}
          exit={{opacity: 0.0, height: "0", transition: {duration: 0.1}}}>
          <PreviewDescription key={href ++ "-description"}>
            <PreviewDescriptionActions key={href ++ "-actions"}>
              <PlayButtonRounded href linkAlt />
            </PreviewDescriptionActions>
            <PreviewDescriptionContent key={href ++ "-description-content"}>
              {switch meta->Array.length > 0 {
              | true =>
                <PreviewDescriptionDotList key={href ++ "-dotlist"}>
                  meta
                </PreviewDescriptionDotList>
              | false => React.null
              }}
              {switch description {
              | Some(description) => <p> {description->React.string} </p>
              | None => React.null
              }}
            </PreviewDescriptionContent>
          </PreviewDescription>
        </Motion.div>
      </Preview>
    </Motion.div>
    <MoviePreviewPresence.Container onExit />
  </MoviePreviewPresence>
})
