import { Category } from '../../../../../res/proxy/ProxyHtml.bs.mjs';

export async function GET(_, segmentData) {
  const params = await segmentData.params;
  return await Category.get(params);
}
