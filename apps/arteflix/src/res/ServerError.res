type props_ = {message: string}

@react.component(: props_)
let make = (~message) =>
  <div>
    <p> {message->React.string} </p>
  </div>
