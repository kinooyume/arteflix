open StorybookMini

let default: meta<Preview.props> = {
  title: "Organisms/Preview",
  component: Preview.make,
}

let hello: storyObj<Preview.props> = {
  args: {
    children: <>
      <PreviewImage href="https://kinoo.dev" srcBase="https://api-cdn.arte.tv/img/v2/image/Uv4rDyMJ2ThY29ofU5PhGK/325x183?type=TEXT" />
      <PreviewDescription>
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
    </PreviewDescription></>,
  },
}
