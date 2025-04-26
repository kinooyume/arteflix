import DirectRes from '../../../res/Redirect.bs.mjs';

export const revalidate = 60;
export const dynamicParams = true;

export let metadata = {
  title: "Arteflix",
  description: "Arte with Netflix UI",
}
export default async function Page({ params }: { params: any }) {
  return DirectRes(params);
}
