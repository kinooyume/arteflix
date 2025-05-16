@schema
type t = {
  zones: array<ArteZone.t>,
  metadata: @s.nullable option<ArteMetadata.t>, // dans la collection uniquement, pour l'instant
  parent: @s.nullable option<ArteCollection.parent>,
}

let contentPlaceholder = {
  zones: [],
  metadata: None,
  parent: None,
}

// NOTE: Used to remove undefined after parsing
external fromJson: Js.Json.t => t = "%identity"
external toJson: t => Js.Json.t = "%identity"
