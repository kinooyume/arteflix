open Emotion

let panelInner = `
  background: rgba(0, 0, 0, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 4px;
  padding: 16px 24px;
  display: flex;
  flex-direction: column;
  gap: 4px;
  min-width: 160px;
`->rawCss

let panel = `
  position: absolute;
  top: 100%;
  left: -24px;
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
  transition: color 0.15s;
  &:hover {
    color: #B3B3B3;
  }
`->rawCss

let wrapper = `
  position: relative;
  margin-top: 3px;
  ${Responsive.mobileDown} {
    display: none;
  }
  &:hover .${panel} {
    opacity: 1;
    pointer-events: auto;
  }
`->rawCss

@react.component
let make = (~label: string, ~children: React.element) =>
  <div className={wrapper}>
    <span className={trigger}> {`${label} \u25BE`->React.string} </span>
    <div className={panel}>
      <div className={panelInner}> {children} </div>
    </div>
  </div>
