import { category } from '../../../../../../res/proxy/ProxyApi.bs.mjs';

export async function GET(_, segmentData) {
  console.log("GET:", segmentData)
  const params = await segmentData.params;
  return await category(params);
}
