import { Urls } from '../adapters/client/ArteApiProxy.bs.mjs';

describe('ArteApiProxy.Urls', () => {
  it('home', () => {
    expect(Urls.home({ lang: 'fr' })).toBe('/proxy/api/fr');
  });

  it('program', () => {
    expect(Urls.program({ lang: 'fr', id: '12345' })).toBe(
      '/proxy/api/fr/program/12345'
    );
  });

  it('collection', () => {
    expect(Urls.collection({ lang: 'de', id: 'RC-001' })).toBe(
      '/proxy/api/de/collection/RC-001'
    );
  });

  it('category', () => {
    expect(Urls.category({ lang: 'fr', slug: 'cinema' })).toBe(
      '/proxy/api/fr/page/cinema'
    );
  });

  it('player', () => {
    expect(Urls.player({ lang: 'fr', id: '098765' })).toBe(
      '/proxy/api/fr/player/098765'
    );
  });

  it('playlist', () => {
    expect(Urls.playlist({ lang: 'es', id: 'PL-999' })).toBe(
      '/proxy/api/es/playlist/PL-999'
    );
  });

  it('trailer', () => {
    expect(Urls.trailer({ lang: 'en', id: 'ABC123' })).toBe(
      '/proxy/api/en/trailer/ABC123'
    );
  });

  it('live', () => {
    expect(Urls.live({ lang: 'fr' })).toBe('/proxy/api/fr/live');
  });
});
