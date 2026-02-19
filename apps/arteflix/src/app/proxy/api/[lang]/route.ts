import { home } from '../../../../res/proxy/ProxyApi.bs.mjs';

type segmentData ={
  params: Promise<any>
}
export async function GET(_, segmentData: segmentData) {
  const params = await segmentData.params;
  const res = await home(params);
  res.headers.set('Cache-Control', 's-maxage=60, stale-while-revalidate=300');
  return res;
}
