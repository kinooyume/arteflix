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
  trailer?: PlayerTransition.url,
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
  ~trailer=?,
) => {
  <HeroImage src={imageSrc} sizes="100vw" alt={imageAlt} overflow ?renderImage ?trailer>
    <HeroContent title subtitle description callToAction href={url} />
  </HeroImage>
}
