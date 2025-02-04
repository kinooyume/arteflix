module Fs = {
  type stat

  type readdirOptions = {withFileTypes: bool}

  @module("fs/promises")
  external readdir: (string, readdirOptions) => Js.Promise.t<array<NodeJs.Fs.Dirent.t>> = "readdir"

  @module("fs/promises")
  external writeFile: (string, 'a) => Js.Promise.t<Js.undefined<string>> = "writeFile"

  @module("fs/promises")
  external readFile: (~path: string, ~encoding: string) => Js.Promise.t<string> = "readFile"

  @module("fs/promises")
  external stat: string => Js.Promise.t<stat> = "stat"
}
