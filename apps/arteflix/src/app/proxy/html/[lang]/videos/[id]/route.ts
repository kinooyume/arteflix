import { Video } from '../../../../../../res/proxy/ProxyHtml.bs.mjs';

export async function GET(_, segmentData) {
  const params = await segmentData.params;
  return await Video.get(params);
}
