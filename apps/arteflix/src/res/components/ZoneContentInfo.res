@react.component
let make = (~content: ArteZoneContent.t) =>
  <li>
    <ImageControlled baseUrl={content.mainImage.url} size="160x90" alt={content.title} />
    <h3> {content.title->React.string} </h3>
    <br />
    <br />
    <br />
    {switch content.availability {
    | Some(availability) =>
      <p> {("Availability: " ++ (availability.availabilityType :> string))->React.string} </p>
    | None => <> </>
    }}
    <br />
  </li>
