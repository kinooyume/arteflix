// NOTE: J'imagine que c'est ça qu'on veut à la fin
// Surement le pageValue
// [ type page ] https://www.arte.tv/api/rproxy/emac/v4/en/web/programs/116705-107-A/
//
// :lang[en], :id[116705-107-A]

@schema
type pageValue = {
  zones: array<ArteZone.t>,
  // metadata: ArteMetadata.t
}

@schema
type page = {value: pageValue}

@schema
type content = {
  zones: array<ArteZone.t>,
  metadata: @s.nullable option<ArteMetadata.t>, // dans la collection uniquement, pour l'instant
  parent: @s.nullable option<ArteCollection.parent>,
}

let contentPlaceholder = {
  zones: [],
  metadata: None,
  parent: None,
}

// NOTE: both when html
@schema
type t = {
  content: content,
  apiPlayerConfig: @s.nullable option<ArtePlayerConfig.t>,
}

// NOTE: Used to remove undefined after parsing
external fromJson: Js.Json.t => t = "%identity"
external toJson: t => Js.Json.t = "%identity"
