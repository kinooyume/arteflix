import { resolvedFetcher, relativeArteLinks } from '../adapters/client/ClientFetcher.bs.mjs';

const item = {
  id: 'item-1',
  kind: { isCollection: false },
  mainImage: { url: 'https://api-cdn.arte.tv/img/1.jpg' },
  title: 'Un film',
  trackingPixel: 'https://example.test/pixel',
  url: '/fr/videos/1/',
};

const zone = (id: string, content: object) => ({
  id,
  code: id,
  title: `Zone ${id}`,
  displayOptions: { template: 'horizontal-landscape', showZoneTitle: true, showItemTitle: true },
  content,
});

const json = (body: unknown) => Promise.resolve(new Response(JSON.stringify(body)));

const page = {
  zones: [
    zone('inline', { data: [item], pagination: null }),
    zone('included', { esiInclude: 'https://api-cdn.arte.tv/zones/included' }),
    zone('broken', { esiInclude: 'https://api-cdn.arte.tv/zones/broken' }),
  ],
  metadata: null,
  parent: null,
};

const fetchMock = jest.fn();

beforeEach(() => {
  fetchMock.mockReset();
  global.fetch = fetchMock;
  jest.spyOn(console, 'warn').mockImplementation(() => undefined);
});

describe('resolvedFetcher', () => {
  it('fills every esiInclude zone and drops the ones that fail', async () => {
    fetchMock.mockImplementation((url: string) => {
      if (url === 'https://page') return json(page);
      if (url.endsWith('/included')) return json({ data: [item], pagination: null });
      return Promise.resolve(new Response('429 - Too Many Requests', { status: 429 }));
    });

    const data = await resolvedFetcher('https://page');

    expect(data.zones.map((z: { content: { data: unknown[] } }) => z.content.data.length)).toEqual([
      1, 1, 0,
    ]);
    expect(data.zones.every((z: { content: { esiInclude?: string } }) => !z.content.esiInclude)).toBe(
      true
    );
  });

  it('does not refetch zones that are already inline', async () => {
    fetchMock.mockImplementation(() => json({ ...page, zones: [page.zones[0]] }));

    await resolvedFetcher('https://page');

    expect(fetchMock).toHaveBeenCalledTimes(1);
  });
});

describe('relativeArteLinks', () => {
  it('turns arte.tv links into app paths and leaves other hosts alone', () => {
    const json = JSON.stringify({
      url: 'https://www.arte.tv/fr/videos/RC-028300/blood/',
      image: 'https://api-cdn.arte.tv/img/v2/image/abc/__SIZE__',
      stream: 'https://artesimulcast.akamaized.net/index.m3u8',
    });

    expect(JSON.parse(relativeArteLinks(json))).toEqual({
      url: '/fr/videos/RC-028300/blood/',
      image: 'https://api-cdn.arte.tv/img/v2/image/abc/__SIZE__',
      stream: 'https://artesimulcast.akamaized.net/index.m3u8',
    });
  });
});
