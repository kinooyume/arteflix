import { Home } from '../../../../res/proxy/ProxyHtml.bs.mjs';

type segmentData ={
  params: Promise<any>
}
export async function GET(_, segmentData: segmentData) {
  const params = await segmentData.params;
  return await Home.get(params);
}
