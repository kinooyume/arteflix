open Emotion
open ReactAria

type lang = {
  code: string,
  label: string,
  href: string,
}

let panelInner = `
  background: rgba(0, 0, 0, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 4px;
  padding: 12px 20px;
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 120px;
`->rawCss

let panel = `
  position: absolute;
  top: 100%;
  right: 0;
  padding-top: 12px;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.15s;
`->rawCss

let trigger = `
  color: #E5E5E5;
  font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
  font-size: clamp(11px, 0.55rem + 0.35vw, 14px);
  font-weight: 500;
  cursor: pointer;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  transition: color 0.15s;
  &:hover {
    color: #B3B3B3;
  }
`->rawCss

let wrapper = `
  position: relative;
  &:hover .${panel} {
    opacity: 1;
    pointer-events: auto;
  }
`->rawCss

let langLink = `
  color: #E5E5E5;
  font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
  font-size: clamp(12px, 0.6rem + 0.4vw, 15px);
  font-weight: 400;
  text-decoration: none;
  padding: 6px 0;
  transition: color 0.15s;
  white-space: nowrap;
  &:hover {
    color: white;
  }
`->rawCss

let activeLang = `
  color: white;
  font-weight: 500;
`->rawCss

@react.component
let make = (~current: string, ~langs: array<lang>) =>
  <div className={wrapper}>
    <span className={trigger}> {`${current} \u25BE`->React.string} </span>
    <div className={panel}>
      <div className={panelInner}>
        {langs
        ->Array.map(l =>
          <Link
            key={l.code}
            className={String(l.code === current ? cx([langLink, activeLang]) : langLink)}
            href={l.href}>
            {l.label->React.string}
          </Link>
        )
        ->React.array}
      </div>
    </div>
  </div>
