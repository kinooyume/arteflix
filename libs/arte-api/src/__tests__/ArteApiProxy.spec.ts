import { Urls } from '../adapters/client/ArteApiProxy.bs.mjs';

const emac = 'https://api-cdn.arte.tv/api/emac/v4';

describe('ArteApiProxy.Urls', () => {
  it('home', () => {
    expect(Urls.home({ lang: 'fr' })).toBe(`${emac}/fr/web/pages/HOME?bypassESI=true`);
  });

  it('live', () => {
    expect(Urls.live({ lang: 'fr' })).toBe(`${emac}/fr/web/pages/LIVE?bypassESI=true`);
  });

  it('page', () => {
    expect(Urls.page('de', 'CATEGORY_CIN')).toBe(
      `${emac}/de/web/pages/CATEGORY_CIN?bypassESI=true`
    );
  });

  it('program', () => {
    expect(Urls.program({ lang: 'fr', id: '12345' })).toBe(
      `${emac}/fr/web/programs/12345?bypassESI=true`
    );
  });

  it('collection', () => {
    expect(Urls.collection({ lang: 'de', id: 'RC-001' })).toBe(
      `${emac}/de/web/collections/RC-001?bypassESI=true`
    );
  });

  it('player', () => {
    expect(Urls.player({ lang: 'fr', id: '098765' })).toBe('/proxy/api/fr/player/098765');
  });

  it('playlist', () => {
    expect(Urls.playlist({ lang: 'es', id: 'PL-999' })).toBe('/proxy/api/es/playlist/PL-999');
  });

  it('trailer', () => {
    expect(Urls.trailer({ lang: 'en', id: 'ABC123' })).toBe('/proxy/api/en/trailer/ABC123');
  });
});
