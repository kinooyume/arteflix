import { parse, localeOf, locales } from '../res/Routes.bs.mjs';

describe('Routes', () => {
  describe('parse', () => {
    it.each([
      ['/', 'Root'],
      ['/fr', { TAG: 'Home', _0: { lang: 'fr' } }],
      ['/fr/', { TAG: 'Home', _0: { lang: 'fr' } }],
      ['/fr/direct', { TAG: 'Live', _0: { lang: 'fr' } }],
      ['/de/live', { TAG: 'Live', _0: { lang: 'de' } }],
      ['/en/direct', { TAG: 'LivePage', _0: { lang: 'en' } }],
      ['/fr/videos/RC-028290/', { TAG: 'Video', _0: { lang: 'fr', id: 'RC-028290' } }],
      [
        '/fr/videos/126168-000-A/la-fugitive/',
        { TAG: 'Video', _0: { lang: 'fr', id: '126168-000-A', title: 'la-fugitive' } },
      ],
      ['/fr/arte-concert/', { TAG: 'Category', _0: { lang: 'fr', slug: 'arte-concert' } }],
      [
        '/fr/videos/cinema/films/drames/',
        { TAG: 'Category', _0: { lang: 'fr', slug: 'videos/cinema/films/drames' } },
      ],
    ])('%s', (path, route) => {
      expect(parse(path)).toEqual(route);
    });

    it('decodes path segments', () => {
      expect(parse('/fr/videos/cin%C3%A9ma/x/y')).toEqual({
        TAG: 'Category',
        _0: { lang: 'fr', slug: 'videos/cinéma/x/y' },
      });
    });
  });

  describe('localeOf', () => {
    it('contains the expected supported locales', () => {
      expect(locales).toEqual(['en', 'fr', 'de', 'es', 'it', 'pl']);
    });

    it.each([
      ['fr-FR', 'fr'],
      ['de-DE', 'de'],
      ['es-ES', 'es'],
      ['it-IT', 'it'],
      ['pl-PL', 'pl'],
      ['en-US', 'en'],
      ['FR', 'fr'],
      ['ja-JP', 'en'],
      ['', 'en'],
    ])('%s → %s', (language, locale) => {
      expect(localeOf(language)).toBe(locale);
    });
  });
});
