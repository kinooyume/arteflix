jest.mock('next/server', () => ({
  NextResponse: { redirect: jest.fn() },
}));

import { getLocale, locales } from '../res/Middleware.bs.mjs';

describe('Middleware', () => {
  describe('locales', () => {
    it('contains the expected supported locales', () => {
      expect(locales).toEqual(['en', 'fr', 'de', 'es', 'it', 'pl']);
    });
  });

  describe('getLocale', () => {
    const mockHeaders = (acceptLanguage: string | null) => ({
      get: (name: string) => (name === 'accept-language' ? acceptLanguage : null),
    });

    it('returns "fr" for accept-language starting with "fr"', () => {
      expect(getLocale(mockHeaders('fr-FR,fr;q=0.9'))).toBe('fr');
    });

    it('returns "de" for accept-language starting with "de"', () => {
      expect(getLocale(mockHeaders('de-DE,de;q=0.9'))).toBe('de');
    });

    it('returns "es" for accept-language starting with "es"', () => {
      expect(getLocale(mockHeaders('es-ES'))).toBe('es');
    });

    it('returns "it" for accept-language starting with "it"', () => {
      expect(getLocale(mockHeaders('it-IT'))).toBe('it');
    });

    it('returns "pl" for accept-language starting with "pl"', () => {
      expect(getLocale(mockHeaders('pl-PL'))).toBe('pl');
    });

    it('returns "en" for accept-language starting with "en"', () => {
      expect(getLocale(mockHeaders('en-US,en;q=0.9'))).toBe('en');
    });

    it('defaults to "en" for unsupported languages', () => {
      expect(getLocale(mockHeaders('ja-JP'))).toBe('en');
    });

    it('defaults to "en" when accept-language header is null', () => {
      expect(getLocale(mockHeaders(null))).toBe('en');
    });

    it('defaults to "en" when accept-language header is undefined', () => {
      const headers = { get: () => undefined };
      expect(getLocale(headers)).toBe('en');
    });

    it('falls back to "en" for uppercase locale not in the list', () => {
      expect(getLocale(mockHeaders('FR-FR'))).toBe('en');
    });
  });
});
