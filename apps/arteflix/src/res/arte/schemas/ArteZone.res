type template = [
  | #"slider-square"
  | #"horizontal-landscapeBigWithSubtitle"
  | #"horizontal-portrait"
  | #"horizontal-landscape"
  | #"horizontal-landscape-genre"
  | #"event-textOnRightSide"
  | #"single-newsletter"
  | #"event-textOnLeftSide"
  | #"horizontal-landscapeBig"
  | #"vertical-landscape"
  | #"ebu-box"
  | #"single-programContent"
  | #"single-collectionContent"
  | #"tableview-playnext"
  | #"vertical-label"
  | #"single-partner"
  | #"verticalFirstHighlighted-landscape"
  | #"slider-landscape"
  | #"tableview-guide"
  | #"single-banner"
  | #"text-linear"
  | #unknown
]

let templateSchema = S.string->S.transform(s => {
  parser: str =>
    switch str {
    | "slider-square" => #"slider-square"
    | "horizontal-landscapeBigWithSubtitle" => #"horizontal-landscapeBigWithSubtitle"
    | "horizontal-portrait" => #"horizontal-portrait"
    | "horizontal-landscape" => #"horizontal-landscape"
    | "horizontal-landscape-genre" => #"horizontal-landscape-genre"
    | "event-textOnRightSide" => #"event-textOnRightSide"
    | "single-newsletter" => #"single-newsletter"
    | "event-textOnLeftSide" => #"event-textOnLeftSide"
    | "horizontal-landscapeBig" => #"horizontal-landscapeBig"
    | "vertical-landscape" => #"vertical-landscape"
    | "ebu-box" => #"ebu-box"
    | "single-programContent" => #"single-programContent"
    | "single-collectionContent" => #"single-collectionContent"
    | "tableview-playnext" => #"tableview-playnext"
    | "vertical-label" => #"vertical-label"
    | "single-partner" => #"single-partner"
    | "verticalFirstHighlighted-landscape" => #"verticalFirstHighlighted-landscape"
    | "slider-landscape" => #"slider-landscape"
    | "tableview-guide" => #"tableview-guide"
    | "single-banner" => #"single-banner"
    | "text-linear" => #"text-linear"
    | other =>
      Console.warn2("[ArteZone] Unknown template:", other)
      #unknown
    },
  serializer: template =>
    switch template {
    | #unknown => "unknown"
    | #"slider-square" => "slider-square"
    | #"horizontal-landscapeBigWithSubtitle" => "horizontal-landscapeBigWithSubtitle"
    | #"horizontal-portrait" => "horizontal-portrait"
    | #"horizontal-landscape" => "horizontal-landscape"
    | #"horizontal-landscape-genre" => "horizontal-landscape-genre"
    | #"event-textOnRightSide" => "event-textOnRightSide"
    | #"single-newsletter" => "single-newsletter"
    | #"event-textOnLeftSide" => "event-textOnLeftSide"
    | #"horizontal-landscapeBig" => "horizontal-landscapeBig"
    | #"vertical-landscape" => "vertical-landscape"
    | #"ebu-box" => "ebu-box"
    | #"single-programContent" => "single-programContent"
    | #"single-collectionContent" => "single-collectionContent"
    | #"tableview-playnext" => "tableview-playnext"
    | #"vertical-label" => "vertical-label"
    | #"single-partner" => "single-partner"
    | #"verticalFirstHighlighted-landscape" => "verticalFirstHighlighted-landscape"
    | #"slider-landscape" => "slider-landscape"
    | #"tableview-guide" => "tableview-guide"
    | #"single-banner" => "single-banner"
    | #"text-linear" => "text-linear"
    },
})

@schema
type theme = [
  | #info
  | #grey
  | #green
  | #pink
  | #white
  | #blue
  | #yellow
  | #cyan
  | #purple
]

@schema
type displayOptions = {
  @s.schema(templateSchema) template: template,
  // theme: @s.nullable option<theme>,
  showZoneTitle: bool,
  showItemTitle: bool,
}

@schema
type authenticateContent = {
  contentId: string,
  displayOptions: displayOptions,
}

@schema
type paginationLink = {
  first: string,
  last: string,
  next: @s.nullable option<string>,
}

@schema
type pagination = {
  links: paginationLink,
  page: int,
  pages: int,
  totalCount: int,
}
@schema
type zoneContent = {
  data: array<ArteZoneContent.t>,
  pagination: @s.nullable option<pagination>,
}

@schema
type link = {
  page: string, // check if it's fixed ?
  title: string,
  url: @s.nullable option<string>,
  deeplink: @s.nullable option<string>,
}

/*
 *  Zone representation
 *
 *  @id: zone id
 *  @code: zone code, hightlights/playlists_HOME, then uuid
 *  @slug
 *  @title: zone title
 *  @description: zone description
 *  @displayOptions: zone display options
 *  @content: zoneContent
 */

@schema
type metadata = {
  title: string,
  description: string,
  // seo, og, twitter
}

@schema
type t = {
  id: string,
  code: string,
  slug: @s.nullable option<string>,
  metadata: @s.nullable option<metadata>,
  title: string,
  description: @s.nullable option<string>,
  content: zoneContent,
  link: @s.nullable option<link>,
  displayOptions: displayOptions,
  authenticatedContent: @s.nullable option<authenticateContent>,
  groupedZonesName: @s.nullable option<string>,
  displayTeaserGenre: @s.nullable option<bool>,
}

// showItemTitle
