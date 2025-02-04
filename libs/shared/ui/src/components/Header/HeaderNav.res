open ReactAria

type headerLink = {
  text: string,
  href: string,
}

type headerNavProps = {
  logo: HeaderLogo.props,
  links: array<headerLink>,
}

@react.component(: headerNavProps)
let make = (~logo, ~links) =>
  <nav>
    <HeaderLogo {...logo} />
    {links
    ->Array.map(link => <Link href={link.href}> {link.text->React.string} </Link>)
    ->React.array}
  </nav>
