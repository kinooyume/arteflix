import { live } from '../../../../../res/proxy/ProxyApi.bs.mjs';

type segmentData ={
  params: Promise<any>
}
export async function GET(_, segmentData: segmentData) {
  const params = await segmentData.params;
  return await live(params);
}
