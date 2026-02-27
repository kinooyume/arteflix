@schema
type parent = {
   id: string,
  @as("type")
  parentType: string,
  page: string,
  label: string,
  url: string,
  // slig: string,
  // deeplink: string,
  // parent: @s.nullable option<parent>,
}

type t = {
  parent: @s.nullable option<parent>,
  metadata: @s.nullable option<ArteMetadata.t>,
}
