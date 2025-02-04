module Style = {
  open Emotion
  let container =
    ReactDOM.Style.make(~padding="20px", ~color="#FFF", ~backgroundColor="#eeee", ())->css
}
