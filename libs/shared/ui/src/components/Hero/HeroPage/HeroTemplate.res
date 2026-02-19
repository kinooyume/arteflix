type heroTemplateProps = {
  imageSrc: string,
  imageAlt: string,
  title: string,
  subtitle: option<string>,
  overflow?: bool,
  description: option<string>,
  url: string,
  callToAction?: option<string>,
  renderImage?: HeroImage.renderImage,
}

@react.component(: heroTemplateProps)
let make = (
  ~imageSrc,
  ~imageAlt,
  ~title,
  ~subtitle,
  ~description,
  ~url,
  ~overflow=true,
  ~callToAction=None,
  ~renderImage=?,
) => {
  <HeroImage src={imageSrc} sizes="100vw" alt={imageAlt} overflow ?renderImage>
    <HeroContent title subtitle description callToAction href={url} />
  </HeroImage>
}
