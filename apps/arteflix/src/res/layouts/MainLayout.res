// @@directive("'use client';")
module Link = Next.Link

// module Navigation = {
//   @react.component
//   let make = () =>
//     <nav className="p-2 h-12 flex border-b border-gray-200 justify-between items-center text-sm">
//       <Link href="/" className="flex items-center w-1/3">
//         <img className="h-6" src="/static/logo.png" />
//       </Link>
//       <div className="flex w-2/3 justify-end">
//         <Link href="/" className="px-3"> {React.string("Home")} </Link>
//         <Link href="/examples" className="px-3"> {React.string("Examples")} </Link>
//         <a
//           className="px-3 font-bold"
//           target="_blank"
//           href="https://github.com/ryyppy/nextjs-default">
//           {React.string("Github")}
//         </a>
//       </div>
//     </nav>
// }

type props = {children: React.element}
let default = ({children}: props) => {
  <html>
    <body>
      <div className="w-full text-white-900 font-base">
        // <Navigation />
        <RouterProvider>

          // context avec  la langue
          <AppHeader />
          <main> children </main>

        </RouterProvider>
      </div>
    </body>
  </html>
}
