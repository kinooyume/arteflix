// __NEXT_DATA__ from website

@schema
type innerPageProps = {
  page: ArteData.page,
  apiPlayerConfig: @s.nullable option<ArtePlayerConfig.t>,
  metadata: @s.nullable option<ArteMetadata.t>, // TODO: specify when needed
  parent: @s.nullable option<ArteCollection.parent>,
}

@schema
type pageProps = {props: innerPageProps}

@schema
type htmlProps = {pageProps: pageProps}

@schema
type t = {props: htmlProps}

// NOTE: Used to remove undefined after parsing
external fromJson: Js.Json.t => t = "%identity"
external toJson: t => Js.Json.t = "%identity"

// Global stuff ? to check
// https://www.arte.tv/api/rproxy/emac/v4/en/web/

// Page content I think, zones quoi

// Api Player
// https://api.arte.tv/api/player/v2/config/fr/112907-091-A

// DIRECT
// https://api.arte.tv/api/player/v2/config/fr/LIVE
//
// https://www.arte.tv/api/rproxy/emac/v4/fr/web/pages/MOST_RECENT/
//
//
//https://github.com/search?q=www.arte.tv%2Fapi%2F&type=code
