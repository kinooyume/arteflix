open Emotion

module Style = {
  let button = `
    display: flex;
    align-items: center;
    justify-content: center;
    width: clamp(32px, 1.6rem + 0.8vw, 44px);
    height: clamp(32px, 1.6rem + 0.8vw, 44px);
    padding: 0;
    border-radius: 50%;
    border: 1px solid ${Colors.primaryWhite};
    background: transparent;
    color: ${Colors.primaryWhite};
    cursor: pointer;
    outline: none;
    transition: background 150ms ease;
    &:hover {
      background: rgba(255, 255, 255, 0.15);
    }
    & svg {
      width: 50%;
      height: 50%;
    }
  `->rawCss
}

type muteButtonProps = {
  muted: bool,
  onToggle: unit => unit,
}

@react.component(: muteButtonProps)
let make = (~muted, ~onToggle) =>
  <ReactAria.Button
    className={String(Style.button)}
    onPress=onToggle
    ariaLabel={muted ? "Activer le son" : "Couper le son"}>
    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M11 5 6 9H2v6h4l5 4V5Z" fill="currentColor" />
      {muted
        ? <path
            d="m16 9 6 6m0-6-6 6" stroke="currentColor" strokeWidth="2" strokeLinecap="round"
          />
        : <path
            d="M15.5 8.5a5 5 0 0 1 0 7M18.5 5.5a9 9 0 0 1 0 13"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
          />}
    </svg>
  </ReactAria.Button>
