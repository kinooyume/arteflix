open Emotion

module Style = {
  let container = `
    padding: 2rem var(--side-padding);
    color: white;
    font-family: monospace;
  `->rawCss

  let message = `
    white-space: pre-wrap;
    color: #ff6b6b;
    font-size: 14px;
    background: rgba(255, 100, 100, 0.1);
    padding: 12px 16px;
    border-radius: 4px;
    border: 1px solid rgba(255, 100, 100, 0.2);
  `->rawCss

  let title = `
    color: #ccc;
    font-size: 16px;
    margin-bottom: 8px;
  `->rawCss
}

type props_ = {message: string}

@react.component(: props_)
let make = (~message) =>
  <div className={Style.container}>
    <p className={Style.title}> {"Error"->React.string} </p>
    <pre className={Style.message}> {message->React.string} </pre>
  </div>
