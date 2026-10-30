open Emotion

module Style = {
  let container = `
    position: relative;
    width: 100%;
    aspect-ratio: 16 / 9;
  `->rawCss

  let media = `
    position: absolute;
    inset: 0;
  `->rawCss

  let image = `
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
  `->rawCss

  let gradient = `
    position: absolute;
    left: 0;
    right: 0;
    bottom: -1px;
    height: 45%;
    background: linear-gradient(0deg, ${Colors.greyGrey_900} 0, transparent 100%);
  `->rawCss

  let content = `
    position: absolute;
    left: clamp(20px, 5%, 48px);
    right: clamp(20px, 5%, 48px);
    bottom: clamp(16px, 6%, 40px);
    display: flex;
    flex-direction: column;
    gap: 16px;
  `->rawCss

  let title = `
    margin: 0;
    font-family: ${Typo.fontFamily};
    max-width: 70%;
    font-size: clamp(24px, 1rem + 2vw, 40px);
    font-weight: 700;
    line-height: 1.1;
  `->rawCss

  let actions = `
    display: flex;
    align-items: center;
    justify-content: space-between;
  `->rawCss
}

type props_ = {
  imageSrc: string,
  imageAlt: string,
  title: string,
  playHref: option<string>,
  trailer?: PlayerTransition.url,
}

let trailerDelay = 1000

@react.component(: props_)
let make = (~imageSrc, ~imageAlt, ~title, ~playHref, ~trailer=PlayerTransition.NoVideo) => {
  let (muted, setMuted) = React.useState(() => true)
  let (playing, setPlaying) = React.useState(() => false)

  <div className={Style.container}>
    <div className={Style.media}>
      <PlayerTransition
        urlOption=trailer
        delay=trailerDelay
        muted
        loop=false
        onPlayingChange={isPlaying => setPlaying(_ => isPlaying)}>
        <img className={Style.image} src=imageSrc alt=imageAlt />
      </PlayerTransition>
    </div>
    <div className={Style.gradient} />
    <div className={Style.content}>
      <h2 className={Style.title}> {title->React.string} </h2>
      <div className={Style.actions}>
        {switch playHref {
        | Some(href) => <ButtonPlay href text="Lecture" />
        | None => <span />
        }}
        {playing ? <MuteButton muted onToggle={() => setMuted(m => !m)} /> : React.null}
      </div>
    </div>
  </div>
}
