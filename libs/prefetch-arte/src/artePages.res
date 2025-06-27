@schema
type tag = [#Ok]

@schema
type alternativeLanguage = {
  code: string,
  label: string,
  url: string,
}

@schema
type page = {
  code: string,
  slug: string,
  deepLink: @s.nullable option<string>,
  description: @s.nullable option<string>,
  href: string,
  label: string,
  alternativeLanguages: @s.nullable option<array<alternativeLanguage>>,
}

@schema
type t = {
  tag: tag,
  value: array<page>,
}
