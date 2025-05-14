import { video } from '../../../../../../../res/proxy/ProxyApi.bs.mjs';

export async function GET(_, segmentData) {
  const params = await segmentData.params;
  return await video(params);
}

