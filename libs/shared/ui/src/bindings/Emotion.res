@module("@emotion/css") external css: ReactDOM.Style.t => string = "css"

@unboxed
type cssArrayElem = Style(ReactDOM.Style.t) | String(string)

@module("@emotion/css") external mergeCss: array<cssArrayElem> => string = "css"
@module("@emotion/css") external rawCss: string => string = "css"
@module("@emotion/css") external keyframes: {..} => string = "css"
@module("@emotion/css") external cx: array<string> => string = "cx"

@module("@emotion/css") external cxConditional: Js.Dict.t<bool> => string = "cx"

@module("@emotion/css") external injectGlobal: string => unit = "injectGlobal"
