let scale = 1.5
let descH = 200.0
let px = v => v->Float.toFixed(~digits=0) ++ "px"

type moviePreviewProps = {
  img: string,
  href: string,
  ageRestriction: option<string>,
  audios: option<array<string>>,
  url?: PlayerTransition.url,
  description: option<string>,
  linkAlt?: option<LinkAlt.make>,
  onExit?: unit => unit,
  isVisible?: bool,
  renderImage?: PreviewImage.renderImage,
  cardWidth?: float,
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
  ~renderImage=?,
  ~cardWidth=218.0,
) => {
  let cardH = cardWidth *. 9.0 /. 16.0
  let expW = cardWidth *. scale
  let expImgH = cardH *. scale
  let totalH = expImgH +. descH

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
      initial={{width: px(cardWidth), height: px(cardH), margin: `0 0 ${px(cardH)} 0`}}
      animate={{width: px(expW), height: px(totalH), margin: "0", transition: {duration: 0.15}}}
      exit={{width: px(cardWidth), height: px(cardH), margin: `0 0 ${px(cardH)} 0`, transition: {duration: 0.08}}}>
      <Preview key={href}>
        <Motion.div
          key={href ++ "-img"}
          initial={{width: px(cardWidth), height: px(cardH)}}
          animate={{width: px(expW), height: px(expImgH), transition: {duration: 0.15}}}
          exit={{width: px(cardWidth), height: px(cardH), transition: {duration: 0.08}}}>
          <PreviewImage srcBase=img href ?renderImage />
        </Motion.div>
        <Motion.div
          key={href ++ "-description"}
          initial={{opacity: 0.0, height: "0"}}
          animate={{opacity: 1.0, height: px(descH), transition: {duration: 0.1, delay: 0.12}}}
          exit={{opacity: 0.0, height: "0", transition: {duration: 0.06}}}>
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
