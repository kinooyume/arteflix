open StorybookMini

let default: meta<PreviewDescription.props> = {
  title: "Molecules/Preview/PreviewDescription",
  component: PreviewDescription.make,
}

let hello: storyObj<PreviewDescription.props> = {
  args: {
    children: <>
      <PreviewDescriptionActions>
        <PlayButtonRounded href="https://kinoo.dev" />
      </PreviewDescriptionActions>
      <PreviewDescriptionContent>
        <PreviewDescriptionList>
          <>
            <PreviewDescriptionListText> "New" </PreviewDescriptionListText>
            <PreviewDescriptionListText> "Emotion" </PreviewDescriptionListText>
            <PreviewDescriptionListText> "3 seasons" </PreviewDescriptionListText>
            <PreviewDescriptionListText> "HD" </PreviewDescriptionListText>
          </>
        </PreviewDescriptionList>
        <PreviewDescriptionDotList>
          [
            <PreviewDescriptionListText> "Violent" </PreviewDescriptionListText>,
            <PreviewDescriptionListText> "Dark" </PreviewDescriptionListText>,
            <PreviewDescriptionListText> "Action" </PreviewDescriptionListText>,
          ]
        </PreviewDescriptionDotList>
      </PreviewDescriptionContent>
    </>,
  },
}
