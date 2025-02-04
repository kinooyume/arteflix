type props_ = {urlPath: string}
@react.component(: props_)
let make = (~urlPath) =>
  <div>
    <p> {"An error happen when fetching data from arte"->React.string} </p>
    <p> {"Here is a link to the official website:"->React.string} </p>
    <a href={"https://www.arte.tv/" ++ urlPath} target="_blank"> {"Arte.tv"->React.string} </a>
  </div>
