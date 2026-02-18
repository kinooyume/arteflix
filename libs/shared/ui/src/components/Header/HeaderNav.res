open ReactAria
open Emotion

type headerLink = {
  text: string,
  href: string,
}

type headerNavProps = {
  logo: HeaderLogo.props,
  links: array<headerLink>,
  categories?: array<headerLink>,
  categoriesLabel?: string,
}

let nav = `
  display: flex;
  align-items: center;
  gap: clamp(12px, 0.5rem + 1vw, 24px);
`->rawCss

let navLinks = `
  display: flex;
  align-items: center;
  gap: clamp(8px, 0.3rem + 0.8vw, 20px);
  ${Responsive.mobileDown} {
    display: none;
  }
`->rawCss

let link = `
  color: #E5E5E5;
  font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
  font-size: clamp(11px, 0.55rem + 0.35vw, 14px);
  font-weight: 500;
  text-decoration: none;
  transition: color 0.15s;
  &:hover {
    color: #B3B3B3;
  }
`->rawCss

let dropdownLink = `
  color: #E5E5E5;
  font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
  font-size: clamp(12px, 0.6rem + 0.4vw, 15px);
  font-weight: 400;
  text-decoration: none;
  padding: 6px 0;
  transition: color 0.15s;
  white-space: nowrap;
  &:hover {
    color: white;
  }
`->rawCss

@react.component(: headerNavProps)
let make = (~logo, ~links, ~categories=?, ~categoriesLabel=?) =>
  <nav className={nav}>
    <HeaderLogo {...logo} />
    <span className={navLinks}>
      {links
      ->Array.map(l => <Link key={l.href} className={String(link)} href={l.href}> {l.text->React.string} </Link>)
      ->React.array}
      {switch categories {
      | Some(cats) =>
        <HeaderDropdown label={categoriesLabel->Option.getOr(`Catégories`)}>
          {cats
          ->Array.map(l =>
            <Link key={l.href} className={String(dropdownLink)} href={l.href}>
              {l.text->React.string}
            </Link>
          )
          ->React.array}
        </HeaderDropdown>
      | None => React.null
      }}
    </span>
  </nav>
