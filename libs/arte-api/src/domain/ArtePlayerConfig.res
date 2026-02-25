open ArteCommon

@schema
type warning = {
  code: string,
  title: string,
  message: string,
}

@schema
type restriction = {
  enablePreroll: bool,
  // geoblocking
  ageResctriction: @s.nullable option<string>,
  // timeSlot: nult
  allowEmbed: bool,
  enableMyArte: bool,
}

@schema
type adsSmart = {url: string}

@schema
type ads = {smart: adsSmart}

// @schema
// type stats = {
//   eStat,
//   arte,
//   agf,
//   push,
//   serverSideTracking
// }

@schema
type streamMainQuality = {
  code: string,
  label: string,
}

@schema
type streamVersion = {
  code: string,
  label: string,
  shortLabel: string,
  // eStat
  audioLanguage: string,
  subtitleLanguage: string,
  closedCaptioning: bool,
  audioDescription: bool,
}

@schema
type stream = {
  url: string,
  versions: array<streamVersion>,
  mainQuality: streamMainQuality,
  slot: int,
  protocol: string,
  // segments: array<segment>
  // externalId: null
}
@schema type streams = array<stream>

@schema
type rights = {
  begin: string,
  end: string,
}

@schema
type duration = {seconds: int}

@schema
type config = {
  url: string,
  replay: @s.nullable option<string>,
  playlist: string,
  // nextPage: null
}

@schema
type image = {
  // caption: null
  url: string,
}

@schema
type attributeMetadata = {
  providerId: string,
  language: string,
  title: string,
  // subtitle: null,
  description: string,
  images: array<image>,
  link: link,
  config: config,
  duration: duration,
  durationReplay: @s.nullable option<duration>,
  episodic: bool,
}

@schema
type attributes = {
  provider: string,
  metadata: attributeMetadata,
  live: bool,
  //chapters: null,
  rights: rights,
  streams: streams,
  // stat: stat,
  ads: ads,
  restriction: restriction,
  // stickers: array<sticker>,
  autoplay: bool,
  warnings: array<warning>,
  // error: null
}

@schema
type t = {
  id: string,
  @as("type")
  playerType: string,
  attributes: attributes,
}

// NOTE: Hum ?
@schema
type player = {
  provider: string,
  title: string,
  image: image,
  link: link,
  config: config,
  duration: duration,
  current: bool,
  live: bool,
  // beginRounded null,
  description: string,
}
