type heroTemplateProps = {
  imageSrc: string,
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
  ~imageAlt,
  ~title,
  ~subtitle,
  ~description,
  ~url,
  ~overflow=true,
  ~callToAction=None,
) =>
  <HeroImage src={imageSrc} alt={imageAlt} overflow>
    <HeroContent title subtitle description callToAction href={url} />
  </HeroImage>
