open StorybookMini

let default: meta<FadeIn.props<React.element>> = {
  title: "Atoms/FadeIn",
  component: FadeIn.make,
}

let text: storyObj<FadeIn.props<React.element>> = {
  args: {
    children: <div>
      <h1> {"Faded in content"->React.string} </h1>
      <p> {"This content fades in on mount."->React.string} </p>
    </div>,
  },
}
