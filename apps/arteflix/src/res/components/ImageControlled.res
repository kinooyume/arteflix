// @react.component
// let make
//

@react.component
let make = (~baseUrl, ~size, ~alt) => {
  let src = String.replace(baseUrl, "__SIZE__", size)
  <img src alt loading=#"lazy" />
}
