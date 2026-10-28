type entry = {
  path: string,
  background: option<string>,
  play: bool,
}

type state = {background: Nullable.t<string>, play: bool}

let eventName = "arteflix:navigate"

@val @scope("history") external pushState: (Nullable.t<state>, string, string) => unit = "pushState"
@val @scope("history") external replaceState: (Nullable.t<state>, string, string) => unit = "replaceState"
@val @scope("history") external back: unit => unit = "back"
@val @scope(("window", "location")) external pathname: string = "pathname"
@val external scrollTo: (float, float) => unit = "scrollTo"

let currentState: unit => state = %raw(`
  function() {
    var s = window.history.state || {};
    return { background: s.background, play: s.play === true };
  }
`)

let notify: unit => unit = %raw(`function() { window.dispatchEvent(new Event("arteflix:navigate")) }`)

let push = (href, ~background=?, ~play=false) => {
  pushState(Nullable.make({background: background->Nullable.fromOption, play}), "", href)
  if background == None {
    scrollTo(0., 0.)
  }
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

let read = () => {
  let {background, play} = currentState()
  {path: pathname, background: background->Nullable.toOption, play}
}

let useLocation = () => {
  let (entry, setEntry) = React.useState(() => None)
  React.useEffect0(() => {
    let sync = () => setEntry(_ => Some(read()))
    sync()
    Some(listen(sync))
  })
  entry
}

let usePath = () => useLocation()->Option.map(entry => entry.path)

let langOf = path =>
  path
  ->String.split("/")
  ->Array.find(s => s != "")
