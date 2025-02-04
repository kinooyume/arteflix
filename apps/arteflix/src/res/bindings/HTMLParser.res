module Element = {
  type node = {rawText: string}
  type t = {childNodes: array<node>}

  @send external querySelector: (t, string) => Js.Nullable.t<t> = "querySelector"
}

@module("node-html-parser")
external parse: string => Js.Nullable.t<Element.t> = "parse"
