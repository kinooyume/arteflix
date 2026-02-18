import LiveRes from '../../../res/pages/LivePage.bs.mjs';

export const revalidate = 60;
export const dynamicParams = true;

export let metadata = {
  title: "Arteflix - Direct",
  description: "Arte Live",
}
export default async function Page({ params }: { params: any }) {
  return await LiveRes(params);
}
