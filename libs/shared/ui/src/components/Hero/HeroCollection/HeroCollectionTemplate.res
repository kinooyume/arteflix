type heroTemplateProps = {
  imageSrc: string,
  imageAlt: string,
  title: string,
  subtitle: option<string>,
  description: option<string>,
  url: string,
  extra?: array<string>,
}

@react.component(: heroTemplateProps)
let make = (~imageSrc, ~imageAlt, ~title, ~subtitle, ~description, ~url, ~extra=[]) => <>
  <HeroImage src={imageSrc} alt={imageAlt}>
    <HeroContent title subtitle=None description=None href={url} small=true />
  </HeroImage>
  <CollectionInfo.Container extra={<CollectionInfo.Extra list={extra} />}>
    <CollectionInfo.Main subtitle description />
  </CollectionInfo.Container>
</>
