@schema
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
  | // NOTE: Video
  #"single-programContent"
  | // NOTE: Collection
  #"single-collectionContent"
  | #"tableview-playnext"
  | #"vertical-label"
  | #"single-partner"
  | #"verticalFirstHighlighted-landscape"
  | // NOTE: Guide
  #"slider-landscape"
  | #"tableview-guide"
  | // NOTE: Genre
  #"single-banner"
]

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
  template: template,
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
  displayTeaserGenre: bool,
}

// showItemTitle
