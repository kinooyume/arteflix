open ReactAria
open Emotion

// TODO: make tiny modules buttons
module Style = {
  let base =
    ReactDOM.Style.make(
      ~display="flex",
      ~flexDirection="column",
      ~justifyContent="center",
      ~textDecoration="none",
      ~alignItems="center",
      ~borderRadius="4px",
      ~border="none",
      ~outline="none",
      ~flexShrink="0",
      (),
    )->css

  let small =
    [
      Typo.Medium.smallBody,
      ReactDOM.Style.make(
        ~width="77px",
        ~height="32px",
        ~padding="4px 16px",
        ~gap="10px",
        ~fontSize="14px",
        (),
      )->css,
    ]->cx

  let medium =
    [
      Typo.Medium.bodyLW,
      ReactDOM.Style.make(
        ~display="flex",
        ~height="42px",
        ~padding="8px 26px 8px 26px",
        ~gap="16px",
        ~fontSize="16px",
        (),
      )->css,
    ]->cx

  let large =
    [
      Typo.Medium.bodyLW,
      ReactDOM.Style.make(
        ~width="314px",
        ~height="40px",
        ~padding="12px 24px",
        ~gap="16px",
        ~fontSize="16px",
        (),
      )->css,
    ]->cx

  let rounded = ReactDOM.Style.make(~borderRadius="20px", ~width="36px", ~height="36px", ~position="relative", ())->css
  let primary =
    ReactDOM.Style.make(~backgroundColor={Colors.primaryRed}, ~color={Colors.primaryWhite}, ())->css

  let primaryHover =
    ReactDOM.Style.make(~backgroundColor={Colors.secondaryRed_200}, ~cursor="pointer", ())->css

  let secondary =
    ReactDOM.Style.make(
      ~backgroundColor={Colors.primaryWhite},
      ~color={Colors.primaryBlack},
      (),
    )->css

  let secondaryHover =
    ReactDOM.Style.make(~backgroundColor={Colors.greyGrey_10}, ~cursor="pointer", ())->css

  let tertiary =
    ReactDOM.Style.make(
      ~backgroundColor={Colors.transparentWhite_20},
      ~color={Colors.primaryWhite},
      (),
    )->css

  let tertiaryHover =
    ReactDOM.Style.make(~backgroundColor={Colors.transparentWhite_15}, ~cursor="pointer", ())->css
}
// NOTE: make modules
type variant = Primary | Secondary | Tertiary

type size = Large | Medium | Small | Rounded

type buttonProps = {
  href: string,
  variant: variant,
  size: size,
  children: React.element,
}

@react.component(: buttonProps)
let make = (~href, ~variant, ~children, ~size) => {
  let sizeStyle = switch size {
  | Large => Style.large
  | Medium => Style.medium
  | Small => Style.small
  | Rounded => Style.rounded
  }
  let (defaultStyle, hoverStyle) = switch variant {
  | Primary => (Style.primary, Style.primaryHover)
  | Secondary => (Style.secondary, Style.secondaryHover)
  | Tertiary => (Style.tertiary, Style.tertiaryHover)
  }

  let defaultStyle = cx([Style.base, sizeStyle, defaultStyle])
  let onHover = cx([defaultStyle, hoverStyle])

  let className: Link.classNameFn = ({isHovered}) => isHovered ? onHover : defaultStyle

  <Link className={Fn(className)} href> children </Link>
}
