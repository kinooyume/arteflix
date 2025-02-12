open StorybookMini

let default: meta<PreviewDescriptionContent.props> = {
  title: "Molecules/Preview/PreviewDescriptionContent",
  component: PreviewDescriptionContent.make,
}

let hello: storyObj<PreviewDescriptionContent.props> = {
  args: {
    children: <>
      <PreviewDescriptionDotList>
        [
          <PreviewDescriptionListText> "Violent" </PreviewDescriptionListText>,
          <PreviewDescriptionListText> "Dark" </PreviewDescriptionListText>,
          <PreviewDescriptionListText> "Action" </PreviewDescriptionListText>,
        ]
      </PreviewDescriptionDotList>
      <p>
        {"1997. Le champion du monde d’échecs Garry Kasparov joue contre le super ordinateur Deep Blue."->React.string}
      </p>
    </>,
  },
}

// module P = {
//   @react.component
//   let make = (~children) => <p className="mb-2"> children </p>
// }
//     <P>
//       {React.string(` This is a simple template for a Next
//       project using ReScript & TailwindCSS.`)}
//     </P>
//
