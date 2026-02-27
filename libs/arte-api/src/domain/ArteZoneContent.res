open ArteCommon

@schema
type contentCode = [
  | #SHOW
  | #TV_SERIES
  | #TOPIC
  | #EXTERNAL
  | #BONUS
  | #MAGAZINE
  | #MANUAL_CLIP
  | #EVENT
  | #LIVE_EVENT
]

@schema
type contentKind = {
  // code: contentCode,
  isCollection: bool,
  label: @s.nullable option<string>,
}

@schema
type stickerCode = [
  | #LIVE
  | #TV_LIVE
  | #PLAYABLE
  | #FULL_VIDEO
  | #COLLECTION
  | #DOC
  | #MOVIE
  | #SERIE
  | #ARTE_CONCERT
  | #CONCERT
  | #LAST_DAY
  | #MAGAZINE
  | #SOON
  | #PRIME_TIME
]

@schema
type sticker = {
  code: string,
  label: string,
}

// video only: #program

@schema
type contentType = [#teaser | #program | #collection]


@schema
type availabilityType = [#VOD | #LIVESTREAM_TV | #LIVESTREAM_WEB | #BROADCAST]

@schema
type availability = {
  @as("type")
  availabilityType: availabilityType,
  end: string,
  label: @s.nullable option<string>,
  start: string,
  upcomingDate: string,
}

@schema
type clip = {
  id: string,
  config: string,
}

// NOTE: Peut etre different selon les types de videos ?
@schema
type trailer = {
  id: string,
  config: string,
}

@schema
type geoblocking = {
  code: string,
  exclusion: array<string>,
  inclusion: array<string>,
}

/* Zone content representation
 *
 * @availability: optional availability info
 * @callToAction: i18n for call to action
 */

// NOTE: check tout ce qui est nullable, ça doit etre pour les videos ?
@schema
type t = {
  deeplink: @s.nullable option<string>,
  id: string,
  kind: contentKind,
  mainImage: image,
  shortDescription: @s.nullable option<string>,
  fullDescription: @s.nullable option<string>,
  stickers: @s.nullable option<array<sticker>>,
  subtitle: @s.nullable option<string>,
  title: string,
  trackingPixel: string,
  // @as("type")
  // contentType: contentType,
  ageRating: @s.nullable option<int>,
  audioVersions: @s.nullable option<array<audioVersion>>,
  availability: @s.nullable option<availability>,
  broadcastDate: @s.nullable option<array<string>>,
  // NOTE: optional in video
  callToAction: @s.nullable option<string>,
  childrenCount: @s.nullable option<int>,
  clip: @s.nullable option<clip>,
  duration: @s.nullable option<int>,
  durationLabel: @s.nullable option<string>,
  geoblocking: @s.nullable option<geoblocking>,
  genre: @s.nullable option<link>,
  programId: @s.nullable option<string>,
  publishEnd: @s.nullable option<string>,
  standaloneContent: @s.nullable option<bool>,
  teaserText: @s.nullable option<string>,
  trailer: @s.nullable option<trailer>, // NOTE: peut etre lier à contentType
  url: string,
}
