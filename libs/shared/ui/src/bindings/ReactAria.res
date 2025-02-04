module HoverEvent = {
  type type_ = [#hoverstart | #hoverend]
  type target = Dom.element

  type t = {
    @as("type")
    type_: type_,
    target: target,
  }
}

module Hooks = {
  type tooltipTriggerState = {
    isOpen: bool,
    @as("open")
    open_: (~immediate: Js.Nullable.t<bool>) => unit,
    close: (~immediate: Js.Nullable.t<bool>) => unit,
  }

  type useTooltipProps = {
    props: {.},
    state?: tooltipTriggerState,
  }

  @module("react-aria")
  external useTooltip: useTooltipProps => React.element = "useTooltip"

  type hoverProps = {
    onHoverStart?: HoverEvent.t => unit,
    onHoverEnd?: HoverEvent.t => unit,
    onHoverChange?: HoverEvent.t => unit,
  }

  type hover = {
    hoverProps: JsxDOM.domProps,
    isHovered: bool,
  }

  @module("react-aria")
  external useHover: hoverProps => hover = "useHover"
}

@untagged
type placement = [
  | #bottom
  | #"bottom left"
  | #"bottom right"
  | #"bottom start"
  | #"bottom end"
  | #top
  | #"top left"
  | #"top right"
  | #"top start"
  | #"top end"
  | #left
  | #"left top"
  | #"left bottom"
  | #start
  | #"start top"
  | #"start bottom"
  | #right
  | #"right top"
  | #"right bottom"
  | #end
  | #"end top"
  | #"end bottom"
]

module TooltipTrigger = {
  type props_ = {
    offset?: int,
    delay?: int,
    closeDelay?: int,
    shouldFlip?: bool,
    onClick?: ReactEvent.Mouse.t => unit,
    placement?: placement,
    children: React.element,
  }

  @module("react-aria-components") @react.component(: props_)
  external make: buttonProps => React.element = "TooltipTrigger"
}

module Tooltip = {
  type props_ = {
    triggerRef?: React.ref<Nullable.t<Dom.element>>,
    offset?: int,
    placement?: placement,
    children: React.element,
  }

  @module("react-aria-components") @react.component(: props_)
  external make: buttonProps => React.element = "Tooltip"
}

module DialogTrigger = {
  type props_ = {
    isOpen?: bool,
    defaultOpen?: bool,
    children: React.element,
    onOpenChange?: bool => unit,
  }

  @module("react-aria-components") @react.component(: props_)
  external make: buttonProps => React.element = "DialogTrigger"
}

module Dialog = {
  type props_ = {
    className?: string,
    styles?: ReactDOM.Style.t,
    children: React.element,
    @as("aria-label")
    ariaLabel?: string,
    @as("aria-labelledby")
    ariaLabelledBy?: string,
    @as("aria-describedby")
    ariaDescribedBy?: string,
    @as("aria-details")
    ariaDetails?: string,
  }

  @module("react-aria-components") @react.component(: props_)
  external make: buttonProps => React.element = "Dialog"
}

module Popover = {
  type props_ = {
    trigger?: string,
    triggerRef?: React.ref<Nullable.t<Dom.element>>,
    isEntering?: bool,
    isExisting?: bool,
    offset?: int,
    className?: string,
    placement?: placement,
    containerPadding?: int,
    children: React.element,
    isOpen?: bool,
  }

  @module("react-aria-components") @react.component(: props_)
  external make: buttonProps => React.element = "Popover"
}

module Link = {
  type linkRenderProps = {
    isHovered: bool,
    isPressed: bool,
    isFocused: bool,
    isFocusVisible: bool,
    isDisabled: bool,
    isPending: bool,
  }

  type classNameFn = linkRenderProps => string

  @unboxed
  type classNameProps = String(string) | Fn(classNameFn)

  type hoverEvent = {
    type_: string,
    target: Dom.element,
  }

  type props_ = {
    href: string,
    className?: classNameProps,
    children: React.element,
    onHoverStart?: HoverEvent.t => unit,
    onHoverChange?: bool => unit,
  }

  @module("react-aria-components") @react.component(: props_)
  external make: buttonProps => React.element = "Link"
}

module Button = {
  type propsFn = {
    isHovered: bool,
    isPressed: bool,
    isFocused: bool,
    isFocusVisible: bool,
    isDisabled: bool,
    isPending: bool,
  }

  type classNameFn = propsFn => string

  @unboxed
  type classNameProps = String(string) | Fn(classNameFn)

  type props_ = {onPress?: unit => unit, className?: classNameProps, children?: React.element}
  @module("react-aria-components") @react.component(: props_)
  external make: props => React.element = "Button"
}
