module HorizontalPortrait = {
  @react.component
  let make = (~zone: ArteZone.t) =>
    <div className="zone-horizontal-portrait">
      <h2> {zone.title->React.string} </h2>
      <h2> {("template: " ++ (zone.displayOptions.template :> string))->React.string} </h2>
      <br />
      <p> {("code: " ++ zone.code)->React.string} </p>
      <p> {("showZoneTitle: " ++ zone.displayOptions.showZoneTitle->String.make)->React.string} </p>
      <p> {("showItemTitle: " ++ zone.displayOptions.showItemTitle->String.make)->React.string} </p>
      <br />
      <ul className="content">
        {zone.content.data
        ->Array.map(content => <ZoneContentInfo content />)
        ->React.array}
      </ul>
    </div>
}

@react.component
let make = (~zone: ArteZone.t) =>
  switch zone.displayOptions.template {
  | #"slider-square" => <HorizontalPortrait zone />
  | #"horizontal-landscapeBigWithSubtitle" => <HorizontalPortrait zone />
  | #"horizontal-portrait" => <HorizontalPortrait zone />
  | #"horizontal-landscape" => <HorizontalPortrait zone />
  | #"horizontal-landscape-genre" => <HorizontalPortrait zone />
  | #"event-textOnRightSide" => <HorizontalPortrait zone />
  | #"single-newsletter" => <HorizontalPortrait zone />
  | _ => <HorizontalPortrait zone />
  }
