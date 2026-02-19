import { trailer } from '../../../../../../res/proxy/ProxyApi.bs.mjs';

export async function GET(_, segmentData) {
  const params = await segmentData.params;
  const res = await trailer(params);
  res.headers.set('Cache-Control', 's-maxage=3600, stale-while-revalidate=7200');
  return res;
}
