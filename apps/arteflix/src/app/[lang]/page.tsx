import HomeRes from '../../res/pages/HomePage.bs.mjs';

export const revalidate = 60;
export const dynamicParams = true;

export let metadata = {
  title: "Arteflix",
  description: "Arte with Netflix UI",
}
export default async function Page({ params }: { params: any }) {
  return await HomeRes(params);
}
