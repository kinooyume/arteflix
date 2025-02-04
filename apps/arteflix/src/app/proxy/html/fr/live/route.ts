import { Live } from '../../../../../res/proxy/ProxyHtml.bs.mjs';

export async function GET(_, _segmentData) {
  return await Live.get({ lang: 'fr' });
}
