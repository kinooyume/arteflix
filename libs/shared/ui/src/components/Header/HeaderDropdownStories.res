open StorybookMini

let default: meta<HeaderDropdown.props<string, React.element>> = {
  title: "Molecules/Header/HeaderDropdown",
  component: HeaderDropdown.make,
}

let categories: storyObj<HeaderDropdown.props<string, React.element>> = {
  args: {
    label: `Catégories`,
    children: [
      <a key="1" href="#"> {`Cinéma`->React.string} </a>,
      <a key="2" href="#"> {`Séries`->React.string} </a>,
      <a key="3" href="#"> {"Sciences"->React.string} </a>,
    ]->React.array,
  },
}
