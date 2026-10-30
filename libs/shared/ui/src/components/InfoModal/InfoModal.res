open Emotion

let appear = keyframes({
  "0%": rawCss("opacity: 0; transform: scale(0.96)"),
  "100%": rawCss("opacity: 1; transform: scale(1)"),
})

module Style = {
  let overlay = `
    position: fixed;
    inset: 0;
    z-index: 1000;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding: clamp(16px, 4vh, 40px) 16px;
    overflow-y: auto;
    overscroll-behavior: contain;
    background: rgba(0, 0, 0, 0.7);
  `->rawCss

  let panel = `
    position: relative;
    width: min(850px, 100%);
    flex-shrink: 0;
    overflow: hidden;
    border-radius: 8px;
    background: ${Colors.greyGrey_900};
    color: ${Colors.primaryWhite};
    box-shadow: 0 6px 32px rgba(0, 0, 0, 0.6);
    animation: ${appear} 200ms ease-out;
  `->rawCss

  let close = `
    position: absolute;
    top: 16px;
    right: 16px;
    z-index: 3;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 36px;
    height: 36px;
    padding: 0;
    border: none;
    border-radius: 50%;
    background: ${Colors.greyGrey_900};
    color: ${Colors.primaryWhite};
    font-size: 20px;
    line-height: 1;
    cursor: pointer;
  `->rawCss
}

let onEscape: (unit => unit) => unit => unit = %raw(`
  function(onClose) {
    function onKey(e) { if (e.key === "Escape") onClose(); }
    window.addEventListener("keydown", onKey);
    return function() { window.removeEventListener("keydown", onKey); };
  }
`)

let lockScroll: unit => unit => unit = %raw(`
  function() {
    if (!document.getElementById("info-modal-scroll-lock")) {
      var style = document.createElement("style");
      style.id = "info-modal-scroll-lock";
      style.textContent = "html[data-info-modal], html[data-info-modal] body { overflow: hidden !important; }";
      document.head.appendChild(style);
    }
    var html = document.documentElement;
    html.setAttribute("data-info-modal", "");
    return function() { html.removeAttribute("data-info-modal"); };
  }
`)

let pauseMediaOutside: Dom.element => unit => unit = %raw(`
  function(modal) {
    var paused = [];
    function pause(video) {
      if (!modal.contains(video) && !video.paused) {
        video.pause();
        paused.push(video);
      }
    }
    document.querySelectorAll("video").forEach(pause);
    function onPlay(e) { if (e.target instanceof HTMLVideoElement) pause(e.target); }
    document.addEventListener("play", onPlay, true);
    return function() {
      document.removeEventListener("play", onPlay, true);
      paused.forEach(function(video) { video.play().catch(function() {}); });
    };
  }
`)

@val @scope("document") external body: Dom.element = "body"

type props_ = {
  label: string,
  onClose: unit => unit,
  children: React.element,
}

@react.component(: props_)
let make = (~label, ~onClose, ~children) => {
  let onCloseRef = React.useRef(onClose)
  onCloseRef.current = onClose
  let panelRef = React.useRef(Nullable.null)

  React.useEffect0(() => {
    let unlock = lockScroll()
    let unlisten = onEscape(() => onCloseRef.current())
    let resume = switch panelRef.current->Nullable.toOption {
    | Some(panel) => pauseMediaOutside(panel)
    | None => () => ()
    }
    Some(
      () => {
        resume()
        unlisten()
        unlock()
      },
    )
  })

  let onOverlayClick = e =>
    if ReactEvent.Mouse.target(e) === ReactEvent.Mouse.currentTarget(e) {
      onClose()
    }

  ReactDOM.createPortal(
    <div className={Style.overlay} onClick=onOverlayClick>
      <div
        className={Style.panel}
        role="dialog"
        ariaModal=true
        ariaLabel=label
        ref={ReactDOM.Ref.domRef(panelRef)}>
        <button className={Style.close} onClick={_ => onClose()} ariaLabel="Fermer">
          {React.string(`✕`)}
        </button>
        children
      </div>
    </div>,
    body,
  )
}
