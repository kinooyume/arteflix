open ArteCommon

@schema 
type publish = {
  online: string,
  offline: @s.nullable option<string>
}

@schema 
type seo = {
  title: string,
  description: string,
  canonical: string
}

@schema type ogImage = {
  url: string,
  width: int,
  height: int
}

@schema 
type og = {
  image: ogImage
}

@schema
type t = {
  title: string,
  subtitle: @s.nullable option<string>,
  description: @s.nullable option<string>,
  publish: @s.nullable  option<publish>,
  totalSeasonNumber: @s.nullable option<int>,
  displayAudioVersion: @s.nullable  option<array<audioVersion>>
  // seo: seo
}
