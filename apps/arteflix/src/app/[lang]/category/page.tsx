import CategoryRes from '../../../res/pages/CategoryPage.bs.mjs';
// Next.js will invalidate the cache when a
// request comes in, at most once every 60 seconds.
export const revalidate = 60;

export let metadata = {
  title: "Arteflix",
  description: "Arte with Netflix UI",
}
// We'll prerender only the params from `generateStaticParams` at build time.
// If a request comes in for a path that hasn't been generated,
// Next.js will server-render the page on-demand.
export const dynamicParams = true; // or false, to 404 on unknown paths

export default async function Page({ params }: { params: any }) {
  return await CategoryRes(params);
}
