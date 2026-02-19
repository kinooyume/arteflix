import { collection } from '../../../../../../res/proxy/ProxyApi.bs.mjs';

export async function GET(_, segmentData) {
  const params = await segmentData.params;
  const res = await collection(params);
  res.headers.set('Cache-Control', 's-maxage=60, stale-while-revalidate=300');
  return res;
}

