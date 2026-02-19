import { live } from '../../../../../res/proxy/ProxyApi.bs.mjs';

type segmentData ={
  params: Promise<any>
}
export async function GET(_, segmentData: segmentData) {
  const params = await segmentData.params;
  const res = await live(params);
  res.headers.set('Cache-Control', 's-maxage=30, stale-while-revalidate=60');
  return res;
}
