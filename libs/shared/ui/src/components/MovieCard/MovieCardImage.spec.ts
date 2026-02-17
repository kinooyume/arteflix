import { ensureTypeText, sizeByOrientation } from './MovieCardImage.bs.mjs';

describe('MovieCardImage', () => {
  describe('ensureTypeText', () => {
    it('appends ?type=TEXT when not present', () => {
      expect(ensureTypeText('https://example.com/image.jpg')).toBe(
        'https://example.com/image.jpg?type=TEXT'
      );
    });

    it('does not double-append when ?type=TEXT is already present', () => {
      expect(
        ensureTypeText('https://example.com/image.jpg?type=TEXT')
      ).toBe('https://example.com/image.jpg?type=TEXT');
    });

    it('works with empty string', () => {
      expect(ensureTypeText('')).toBe('?type=TEXT');
    });
  });

  describe('sizeByOrientation', () => {
    it('returns "325x183" for Horizontal', () => {
      expect(sizeByOrientation('Horizontal')).toBe('325x183');
    });

    it('returns "265x397" for Vertical', () => {
      expect(sizeByOrientation('Vertical')).toBe('265x397');
    });
  });
});
