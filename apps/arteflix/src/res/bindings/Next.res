module GetServerSideProps = {
  module Req = {
    type t = {url: string}
  }

  module Res = {
    type t

    @send external setHeader: (t, string, string) => unit = "setHeader"
    @send external write: (t, string) => unit = "write"
    @send external end: t => unit = "end"
  }

  // See: https://github.com/zeit/next.js/blob/canary/packages/next/types/index.d.ts
  type context<'props, 'params, 'previewData> = {
    params: 'params,
    query: Dict.t<string>,
    preview: option<bool>, // preview is true if the page is in the preview mode and undefined otherwise.
    previewData: Nullable.t<'previewData>,
    req: Req.t,
    res: Res.t,
  }

  // The definition of a getServerSideProps function
  type t<'props, 'params, 'previewData> = context<'props, 'params, 'previewData> => promise<{
    "props": 'props,
  }>
}

module GetStaticProps = {
  // See: https://github.com/zeit/next.js/blob/canary/packages/next/types/index.d.ts
  type context<'props, 'params, 'previewData> = {
    params: 'params,
    preview: option<bool>, // preview is true if the page is in the preview mode and undefined otherwise.
    previewData: Nullable.t<'previewData>,
  }

  // The definition of a getStaticProps function
  type t<'props, 'params, 'previewData> = context<'props, 'params, 'previewData> => promise<{
    "props": 'props,
  }>
}

module GetStaticPaths = {
  // 'params: dynamic route params used in dynamic routing paths
  // Example: pages/[id].js would result in a 'params = { id: string }
  type path<'params> = {params: 'params}

  type return<'params> = {
    paths: array<path<'params>>,
    fallback: bool,
  }

  // The definition of a getStaticPaths function
  type t<'params> = unit => promise<return<'params>>
}

module Link = {
  type props_ = {
    href: string,
    _as?: string,
    prefetch?: bool,
    replace?: bool,
    shallow?: bool,
    passHref?: bool,
    className?: string,
    children: React.element,
  }
  @module("next/link") @react.component(: props_)
  external make: (
    ~href: string,
    ~_as: string=?,
    ~prefetch: bool=?,
    ~replace: bool=?,
    ~shallow: bool=?,
    ~passHref: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "default"
}

// NOTE: Old router
module Router = {
  /*
      Make sure to only register events via a useEffect hook!
 */
  module Events = {
    type t

    @send
    external on: (
      t,
      @string
      [
        | #routeChangeStart(string => unit)
        | #routeChangeComplete(string => unit)
        | #hashChangeComplete(string => unit)
      ],
    ) => unit = "on"

    @send
    external off: (
      t,
      @string
      [
        | #routeChangeStart(string => unit)
        | #routeChangeComplete(string => unit)
        | #hashChangeComplete(string => unit)
      ],
    ) => unit = "off"
  }

  type router = {
    route: string,
    asPath: string,
    events: Events.t,
    pathname: string,
    query: Dict.t<string>,
  }

  type pathObj = {
    pathname: string,
    query: Dict.t<string>,
  }

  @send external push: (router, string) => unit = "push"
  @send external pushObj: (router, pathObj) => unit = "push"

  @module("next/router") external useRouter: unit => router = "useRouter"

  @send external replace: (router, string) => unit = "replace"
  @send external replaceObj: (router, pathObj) => unit = "replace"
}

module Head = {
  @module("next/head") @react.component
  external make: (~children: React.element) => React.element = "default"
}

module Error = {
  @module("next/error") @react.component
  external make: (~statusCode: int, ~children: React.element) => React.element = "default"
}

module Dynamic = {
  type options = {
    ssr?: bool,
    loading?: unit => React.element,
  }

  @module("next/dynamic")
  external dynamic: (unit => promise<'a>, options) => 'a = "default"
}

module Image = {
  type imageLoaderProps = {
    src: string,
    width: int,
    quality?: int,
  }

  @module("next/image") @react.component
  external make: (
    ~src: string,
    ~width: int=?,
    ~height: int=?,
    ~alt: string,
    ~loader: imageLoaderProps=?,
    ~fill: bool=?,
    ~sizes: string=?,
    ~quality: int=?,
    ~priority: bool=?,
    ~placholder: [#blur | #empty]=?,
    ~loading: [#eager | #"lazy"]=?,
    ~blurDataURL: string=?,
    ~unoptimized: bool=?,
    ~overrideSrc: string=?,
    ~className: string=?,
  ) => React.element = "default"
}

module Server = {
  type nextUrl = {
    basePath: string,
    buildId: option<string>,
    pathname: string,
    origin: string,
    searchParams: Js.Dict.t<string>,
  }

  type reqPage = {
    name: string,
    params: Js.Dict.t<string>,
  }

  module Header = {
    type t = {get: string => Js.Nullable.t<string>}

    @module("next/headers")
    external make: unit => t = "headers"
  }

  type nextRequest = {
    nextUrl: nextUrl,
    page: reqPage,
    headers: Header.t,
  }

  type rec nextResponse = {
    next: unit => unit,
    redirect: WebApiURL.t => nextResponse,
  }

  @module("next/server")
  external nextResponse: nextResponse = "NextResponse"
}

module NextResponse = {
  type t

  type status =
    | @as(200) Success
    | @as(400) BadRequest
    | @as(403) Forbidden
    | @as(404) NotFound
    | @as(500) ServerError

  exception ApiError(status)

  type options = {status?: status, statusText?: string, headers?: GreenfinityNext_Fetch.Headers.t}

  @module("next/server") @new
  external make: ('a, ~options: options=?) => promise<t> = "NextResponse"
  @module("next/server") @scope("NextResponse")
  external json: (Js.Json.t, ~options: options=?) => promise<t> = "json"
}

module Middleware = {
  type config = {matcher: string}
  type middleware = Server.nextRequest => Server.nextResponse
  // type middleware = unit => unit
}

module Navigation = {
  type router = {
    push: string => unit,
    redirect: string => unit,
    refresh: unit => unit,
    prefetch: (~href: string) => unit,
    back: unit => unit,
    forward: unit => unit,
  }

  @module("next/navigation") external usePathname: unit => string = "usePathname"
  @module("next/navigation") external useParams: unit => Js.Dict.t<string> = "useParams"
  @module("next/navigation") external useRouter: unit => router = "useRouter"
  @module("next/navigation") external redirect: string => Server.nextResponse = "redirect"
}
