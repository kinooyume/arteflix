// open Emotion
//
// let style = ReactDOM.Style.make(
//   ~display="flex",
//   ~flexDirection="column",
//   ~gap="22px",
//   ~maxWidth="518px",
//   ~flexShrink="0",
//   (),
// )->css
//
// type props_ = {
//   title: string,
//   subtitle: option<string>,
//   description: option<string>,
//   overflow?: bool,
//   href: string
// }
//
// @react.component(: props_)
// let make = (~title, ~subtitle, ~description, ~href, ~overflow=false) => {
//   <div className={style}>
//     <HeroTitle title={title} subtitle={subtitle} />
//     {switch description {
//     | Some(description) => <p className={Typo.Regular.headline2}> {description->React.string} </p>
//     | None => <> </>
//     }}
//     <ButtonPlay href />
//   </div>
// }
//
// // T
