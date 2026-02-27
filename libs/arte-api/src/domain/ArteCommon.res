@schema
type image = {
  caption: @s.nullable option<string>,
  url: string,
}

@schema
type link = {
  deepLink: @s.nullable option<string>,
  label: @s.nullable option<string>,
  url: @s.nullable option<string>,
}

// type audioCode = [#AD | #STM | #ST | #VO | #VF | #DE | #"Omu"]
@schema
type audioVersion = {
  code: string,
  label: string,
}


