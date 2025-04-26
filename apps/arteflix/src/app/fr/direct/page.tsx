import LiveRes from '../../../res/Live.bs.mjs';

export const revalidate = 60;
export const dynamicParams = true;

export let metadata = {
  title: 'Arteflix',
  description: 'Arte with Netflix UI',
};
export default async function Page({ params }: { params: any }) {
  return LiveRes(params);
}
