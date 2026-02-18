type heroTemplateProps = {
  imageSrc: string,
  imageSrcSet?: string,
  imageAlt: string,
  title: string,
  subtitle: option<string>,
  overflow?: bool,
  description: option<string>,
  url: string,
  callToAction?: option<string>,
}

@react.component(: heroTemplateProps)
let make = (
  ~imageSrc,
  ~imageSrcSet=?,
  ~imageAlt,
  ~title,
  ~subtitle,
  ~description,
  ~url,
  ~overflow=true,
  ~callToAction=None,
) => {
  let srcSet = imageSrcSet
  <HeroImage src={imageSrc} ?srcSet sizes="100vw" alt={imageAlt} overflow>
    <HeroContent title subtitle description callToAction href={url} />
  </HeroImage>
}
