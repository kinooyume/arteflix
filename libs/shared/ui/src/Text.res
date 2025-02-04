open Emotion
module Regular = {
  module Headline1 = {
    @react.component
    let make = (~children) => {
      <h2 className={[Typo.Regular.headline1, Colors.Text.primaryWhite]->cx}>
        {children}
      </h2>
    }
  }
  module Headline2 = {
    @react.component
    let make = (~children) => {
      <h2 className={[Typo.Regular.headline2, Colors.Text.primaryWhite]->cx}>
        {children}
      </h2>
    }
  }

  module Title1 = {
    @react.component
    let make = (~children) => {
      <h2 className={[Typo.Regular.title1, Colors.Text.primaryWhite]->cx}> {children} </h2>
    }
  }

  module Title2 = {
    @react.component
    let make = (~children) => {
      <h2 className={[Typo.Regular.title2, Colors.Text.primaryWhite]->cx}> {children} </h2>
    }
  }
  module Body = {
    @react.component
    let make = (~children) => {
      <p className={[Typo.Regular.body, Colors.Text.primaryWhite]->cx}> {children} </p>
    }
  }
  module SmallBody = {
    @react.component
    let make = (~children) => {
      <p className={[Typo.Regular.smallBody, Colors.Text.primaryWhite]->cx}> {children} </p>
    }
  }
  module SmallBodyGreen = {
    @react.component
    let make = (~children) => {
      <p className={[Typo.Regular.smallBody, Colors.Text.secondaryGreen]->cx}> {children} </p>
    }
  }
}

module Medium = {
  module Title3 = {
    @react.component
    let make = (~children) => {
      <p className={[Typo.Medium.title3, Colors.Text.primaryWhite]->cx}> {children} </p>
    }
  }
  module Headline2 = {
    @react.component
    let make = (~children) => {
      <h2 className={[Typo.Medium.title3, Colors.Text.greyGrey_20]->cx}>
        {children}
      </h2>
    }
  }
  module SmallBody = {
    @react.component
    let make = (~children) => {
      <p className={[Typo.Medium.smallBody, Colors.Text.primaryWhite]->cx}>
        {children}
      </p>
    }
  }

  module SmallBodyGreen = {
    @react.component
    let make = (~children) => {
      <p className={[Typo.Medium.smallBody, Colors.Text.secondaryGreen]->cx}>
        {children}
      </p>
    }
  }
}

module Bold = {
  module Title1 = {
    @react.component
    let make = (~children) => {
      <p className={[Typo.Bold.title1, Colors.Text.primaryWhite]->cx}>
        {children}
      </p>
    }
  }

}
