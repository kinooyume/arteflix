let eventName = "arteflix:navigate"

@val @scope("history") external pushState: (Nullable.t<'a>, string, string) => unit = "pushState"
@val @scope("history") external replaceState: (Nullable.t<'a>, string, string) => unit = "replaceState"
@val @scope(("window", "location")) external pathname: string = "pathname"
@val external scrollTo: (float, float) => unit = "scrollTo"

let notify: unit => unit = %raw(`function() { window.dispatchEvent(new Event("arteflix:navigate")) }`)

let push = href => {
  pushState(Nullable.null, "", href)
  scrollTo(0., 0.)
  notify()
}

let replace = href => {
  replaceState(Nullable.null, "", href)
  notify()
}

let listen: (unit => unit) => unit => unit = %raw(`
  function(sync) {
    window.addEventListener("popstate", sync);
    window.addEventListener("arteflix:navigate", sync);
    return function() {
      window.removeEventListener("popstate", sync);
      window.removeEventListener("arteflix:navigate", sync);
    };
  }
`)

let usePath = () => {
  let (path, setPath) = React.useState(() => None)
  React.useEffect0(() => {
    let sync = () => setPath(_ => Some(pathname))
    sync()
    Some(listen(sync))
  })
  path
}

let langOf = path =>
  path
  ->String.split("/")
  ->Array.find(s => s != "")
