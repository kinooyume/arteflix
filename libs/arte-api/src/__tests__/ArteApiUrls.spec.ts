jest.mock('../domain/ArteDataApi.bs.mjs', () => ({
  contentSchema: {},
  playerSchema: {},
}));

import { Urls } from '../adapters/server/ArteApi.bs.mjs';

describe('ArteApi.Urls', () => {
  describe('home', () => {
    it('builds the correct home URL for a given language', () => {
      expect(Urls.home({ lang: 'fr' })).toBe(
        'https://www.arte.tv/api/rproxy/emac/v4/fr/web/pages/HOME'
      );
    });

    it('works with different languages', () => {
      expect(Urls.home({ lang: 'de' })).toBe(
        'https://www.arte.tv/api/rproxy/emac/v4/de/web/pages/HOME'
      );
    });
  });

  describe('category', () => {
    it('builds the correct category URL', () => {
      expect(Urls.category('fr', 'CIN')).toBe(
        'https://www.arte.tv/api/rproxy/emac/v4/fr/web/pages/CIN'
      );
    });
  });

  describe('program', () => {
    it('builds the correct program URL', () => {
      expect(Urls.program({ lang: 'fr', id: '12345' })).toBe(
        'https://www.arte.tv/api/rproxy/emac/v4/fr/web/programs/12345'
      );
    });
  });

  describe('collection', () => {
    it('builds the correct collection URL', () => {
      expect(Urls.collection({ lang: 'de', id: 'RC-001' })).toBe(
        'https://www.arte.tv/api/rproxy/emac/v4/de/web/collections/RC-001'
      );
    });
  });

  describe('player', () => {
    it('builds the correct player config URL', () => {
      expect(Urls.player({ lang: 'fr', id: '098765' })).toBe(
        'https://api.arte.tv/api/player/v2/config/fr/098765'
      );
    });
  });

  describe('trailer', () => {
    it('builds the correct trailer URL', () => {
      expect(Urls.trailer({ lang: 'en', id: 'ABC123' })).toBe(
        'https://api.arte.tv/api/player/v2/trailer/en/ABC123'
      );
    });
  });

  describe('playlist', () => {
    it('builds the correct playlist URL', () => {
      expect(Urls.playlist({ lang: 'es', id: 'PL-999' })).toBe(
        'https://api.arte.tv/api/player/v2/playlist/es/PL-999'
      );
    });
  });

  describe('live', () => {
    it('builds the correct live URL', () => {
      expect(Urls.live({ lang: 'fr' })).toBe(
        'https://www.arte.tv/api/rproxy/emac/v4/fr/web/pages/LIVE'
      );
    });
  });
});
