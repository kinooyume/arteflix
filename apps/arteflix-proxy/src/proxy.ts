const ARTE_PLAYER_API = 'https://api.arte.tv/api/player/v2';
const LANGS = new Set(['fr', 'de', 'en', 'es', 'pl', 'it']);
const ROUTE = /^\/proxy\/api\/([a-z]{2})\/(player|trailer|playlist)\/([A-Za-z0-9_-]+)$/;
const ARTE_KIND = { player: 'config', trailer: 'trailer', playlist: 'playlist' };
const FALLBACK_CACHE_CONTROL = 'public, max-age=10, s-maxage=30';

export type Env = { ALLOWED_ORIGINS: string };

export type Client = { ip: string | null; country: string };

export type ResponseCache = {
  match: (request: Request) => Promise<Response | undefined>;
  put: (request: Request, response: Response) => Promise<void>;
};

const corsHeaders = (request: Request, env: Env): Record<string, string> => {
  const origin = request.headers.get('Origin');
  const allowed = env.ALLOWED_ORIGINS.split(',').map((o) => o.trim());
  if (!origin || !allowed.includes(origin)) return {};
  return {
    'Access-Control-Allow-Origin': origin,
    'Access-Control-Allow-Methods': 'GET, OPTIONS',
    Vary: 'Origin',
  };
};

const withHeaders = (response: Response, headers: Record<string, string>) => {
  const res = new Response(response.body, response);
  for (const [key, value] of Object.entries(headers)) res.headers.set(key, value);
  return res;
};

const error = (status: number, message: string, headers: Record<string, string> = {}) =>
  new Response(JSON.stringify({ error: message }), {
    status,
    headers: { 'Content-Type': 'application/json', 'Cache-Control': 'no-store', ...headers },
  });

const fetchPlayer = async (url: string, clientIp: string | null) => {
  const headers: Record<string, string> = { Accept: 'application/json' };
  if (clientIp) headers['X-Forwarded-For'] = clientIp;
  const upstream = await fetch(url, { headers });

  if (upstream.status === 429) {
    return error(503, 'arte rate limited', {
      'Retry-After': upstream.headers.get('Retry-After') ?? '30',
    });
  }
  if (!upstream.ok) return error(upstream.status === 404 ? 404 : 502, `arte ${upstream.status}`);

  let data: unknown;
  try {
    data = JSON.parse(await upstream.text()).data;
  } catch {
    return error(502, 'arte returned invalid json');
  }
  if (data === undefined) return error(502, 'arte returned no data');

  return new Response(JSON.stringify(data), {
    headers: {
      'Content-Type': 'application/json',
      'Cache-Control': upstream.headers.get('Cache-Control') ?? FALLBACK_CACHE_CONTROL,
    },
  });
};

export const handle = async (
  request: Request,
  env: Env,
  cache: ResponseCache,
  waitUntil: (promise: Promise<unknown>) => void,
  client: Client
): Promise<Response> => {
  const cors = corsHeaders(request, env);

  if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: cors });
  if (request.method !== 'GET') return error(405, 'method not allowed', cors);

  const url = new URL(request.url);
  const match = url.pathname.match(ROUTE);
  if (!match || !LANGS.has(match[1])) return error(404, 'not found', cors);

  const [, lang, kind, id] = match;
  const cacheKey = new Request(`${url.origin}${url.pathname}?country=${client.country}`);

  const cached = await cache.match(cacheKey);
  if (cached) return withHeaders(cached, { ...cors, 'X-Proxy-Cache': 'HIT' });

  const response = await fetchPlayer(
    `${ARTE_PLAYER_API}/${ARTE_KIND[kind as keyof typeof ARTE_KIND]}/${lang}/${id}`,
    client.ip
  );
  if (response.ok) waitUntil(cache.put(cacheKey, response.clone()));

  return withHeaders(response, { ...cors, 'X-Proxy-Cache': 'MISS' });
};
