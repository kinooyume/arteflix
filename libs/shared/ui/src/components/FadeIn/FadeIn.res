@react.component
let make = (~children) =>
  <FramerMotion.Motion.div
    initial={{opacity: 0.0}} animate={{opacity: 1.0, transition: {duration: 0.3}}}>
    children
  </FramerMotion.Motion.div>
