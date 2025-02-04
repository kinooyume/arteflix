@@directive("'use client';")
open ReactAriaProvider

@react.component
let make = (~children) => {
  let router = Next.Navigation.useRouter()
  <RouterProvider navigate={router.push}> children </RouterProvider>
}
