import { handle, type ResponseCache } from './proxy';

const env = { ALLOWED_ORIGINS: 'https://arteflix.kinoo.dev, http://localhost:3000' };

const memoryCache = (): ResponseCache & { store: Map<string, Response> } => {
  const store = new Map<string, Response>();
  return {
    store,
    match: async (req) => store.get(req.url)?.clone(),
    put: async (req, res) => {
      store.set(req.url, res);
    },
  };
};

const client = { ip: '203.0.113.7', country: 'FR' };

const pending: Promise<unknown>[] = [];
const waitUntil = (p: Promise<unknown>) => {
  pending.push(p);
};

const get = (path: string, origin = 'https://arteflix.kinoo.dev') =>
  new Request(`https://arteflix.kinoo.dev${path}`, { headers: { Origin: origin } });

const arteResponse = (body: string, init: ResponseInit = {}) =>
  new Response(body, {
    headers: { 'Cache-Control': 'public, max-age=10, s-maxage=30' },
    ...init,
  });

const fetchMock = jest.fn<Promise<Response>, [string, RequestInit?]>();

beforeEach(() => {
  fetchMock.mockReset();
  pending.length = 0;
  global.fetch = fetchMock as unknown as typeof fetch;
});

describe('handle', () => {
  it('proxies the player config and unwraps data', async () => {
    fetchMock.mockResolvedValue(arteResponse('{"data":{"id":"123_fr"}}'));

    const res = await handle(get('/proxy/api/fr/player/123-000-A'), env, memoryCache(), waitUntil, client);

    expect(fetchMock).toHaveBeenCalledWith(
      'https://api.arte.tv/api/player/v2/config/fr/123-000-A',
      expect.anything()
    );
    expect(res.status).toBe(200);
    expect(await res.json()).toEqual({ id: '123_fr' });
    expect(res.headers.get('Cache-Control')).toBe('public, max-age=10, s-maxage=30');
    expect(res.headers.get('Access-Control-Allow-Origin')).toBe('https://arteflix.kinoo.dev');
  });

  it('maps trailer and playlist to their arte endpoints', async () => {
    fetchMock.mockImplementation(async () => arteResponse('{"data":{}}'));
    const cache = memoryCache();

    await handle(get('/proxy/api/de/trailer/RC-028300'), env, cache, waitUntil, client);
    await handle(get('/proxy/api/de/playlist/RC-028300'), env, cache, waitUntil, client);

    expect(fetchMock.mock.calls.map(([url]) => url)).toEqual([
      'https://api.arte.tv/api/player/v2/trailer/de/RC-028300',
      'https://api.arte.tv/api/player/v2/playlist/de/RC-028300',
    ]);
  });

  it('serves the second request from cache', async () => {
    fetchMock.mockResolvedValue(arteResponse('{"data":{"id":"1"}}'));
    const cache = memoryCache();

    await handle(get('/proxy/api/fr/player/1'), env, cache, waitUntil, client);
    await Promise.all(pending);
    const res = await handle(get('/proxy/api/fr/player/1'), env, cache, waitUntil, client);

    expect(fetchMock).toHaveBeenCalledTimes(1);
    expect(res.headers.get('X-Proxy-Cache')).toBe('HIT');
    expect(await res.json()).toEqual({ id: '1' });
  });

  it('does not cache an invalid arte body', async () => {
    fetchMock.mockResolvedValue(arteResponse('{"data": \n429 - Too Many Requests\n}'));
    const cache = memoryCache();

    const res = await handle(get('/proxy/api/fr/player/1'), env, cache, waitUntil, client);

    expect(res.status).toBe(502);
    expect(cache.store.size).toBe(0);
  });

  it('turns an arte 429 into a 503 with Retry-After', async () => {
    fetchMock.mockResolvedValue(new Response('429 - Too Many Requests', { status: 429 }));
    const cache = memoryCache();

    const res = await handle(get('/proxy/api/fr/player/1'), env, cache, waitUntil, client);

    expect(res.status).toBe(503);
    expect(res.headers.get('Retry-After')).toBe('30');
    expect(res.headers.get('Cache-Control')).toBe('no-store');
    expect(cache.store.size).toBe(0);
  });

  it('passes a 404 through', async () => {
    fetchMock.mockResolvedValue(new Response('', { status: 404 }));

    const res = await handle(get('/proxy/api/fr/player/nope'), env, memoryCache(), waitUntil, client);

    expect(res.status).toBe(404);
  });

  it.each([
    '/proxy/api/fr/program/123',
    '/proxy/api/xx/player/123',
    '/proxy/api/fr/player/../../secret',
    '/proxy/api/fr/player/a.b',
    '/other',
  ])('rejects %s without calling arte', async (path) => {
    const res = await handle(get(path), env, memoryCache(), waitUntil, client);

    expect(res.status).toBe(404);
    expect(fetchMock).not.toHaveBeenCalled();
  });

  it('never forwards the query string', async () => {
    fetchMock.mockResolvedValue(arteResponse('{"data":{}}'));

    await handle(
      get('/proxy/api/fr/player/1?redirect=https://evil.example'),
      env,
      memoryCache(),
      waitUntil,
      client
    );

    expect(fetchMock).toHaveBeenCalledWith(
      'https://api.arte.tv/api/player/v2/config/fr/1',
      expect.anything()
    );
  });

  it('forwards the visitor ip so arte geolocates the visitor', async () => {
    fetchMock.mockResolvedValue(arteResponse('{"data":{}}'));

    await handle(get('/proxy/api/fr/player/1'), env, memoryCache(), waitUntil, client);

    expect(fetchMock.mock.calls[0][1]?.headers).toMatchObject({
      'X-Forwarded-For': '203.0.113.7',
    });
  });

  it('keeps one cache entry per country', async () => {
    fetchMock.mockImplementation(async () => arteResponse('{"data":{}}'));
    const cache = memoryCache();

    await handle(get('/proxy/api/fr/player/1'), env, cache, waitUntil, client);
    await Promise.all(pending);
    const res = await handle(get('/proxy/api/fr/player/1'), env, cache, waitUntil, {
      ip: '198.51.100.1',
      country: 'GB',
    });

    expect(fetchMock).toHaveBeenCalledTimes(2);
    expect(res.headers.get('X-Proxy-Cache')).toBe('MISS');
  });

  it('omits CORS headers for unknown origins', async () => {
    fetchMock.mockResolvedValue(arteResponse('{"data":{}}'));

    const res = await handle(
      get('/proxy/api/fr/player/1', 'https://evil.example'),
      env,
      memoryCache(),
      waitUntil,
      client
    );

    expect(res.headers.get('Access-Control-Allow-Origin')).toBeNull();
  });

  it('answers preflight requests', async () => {
    const res = await handle(
      new Request('https://arteflix.kinoo.dev/proxy/api/fr/player/1', {
        method: 'OPTIONS',
        headers: { Origin: 'http://localhost:3000' },
      }),
      env,
      memoryCache(),
      waitUntil,
      client
    );

    expect(res.status).toBe(204);
    expect(res.headers.get('Access-Control-Allow-Origin')).toBe('http://localhost:3000');
  });
});
