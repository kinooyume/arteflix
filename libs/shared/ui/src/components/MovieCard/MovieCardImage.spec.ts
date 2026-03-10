import { sizeByOrientation } from './MovieCardImage.bs.mjs';
import { ensureTypeText, stripTypeText } from '../../hooks/UseAsset.bs.mjs';

describe('MovieCardImage', () => {
  describe('sizeByOrientation', () => {
    it('returns "336x189" for Horizontal', () => {
      expect(sizeByOrientation('Horizontal')).toBe('336x189');
    });

    it('returns "265x397" for Vertical', () => {
      expect(sizeByOrientation('Vertical')).toBe('265x397');
    });
  });
});

describe('UseAsset', () => {
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

    it('appends with & when URL already has params', () => {
      expect(ensureTypeText('https://example.com/image.jpg?foo=bar')).toBe(
        'https://example.com/image.jpg?foo=bar&type=TEXT'
      );
    });

    it('works with empty string', () => {
      expect(ensureTypeText('')).toBe('?type=TEXT');
    });
  });

  describe('stripTypeText', () => {
    it('removes ?type=TEXT from URL', () => {
      expect(stripTypeText('https://example.com/image.jpg?type=TEXT')).toBe(
        'https://example.com/image.jpg'
      );
    });

    it('removes &type=TEXT preserving other params', () => {
      expect(stripTypeText('https://example.com/image.jpg?foo=bar&type=TEXT')).toBe(
        'https://example.com/image.jpg?foo=bar'
      );
    });

    it('removes ?type=TEXT& preserving other params', () => {
      expect(stripTypeText('https://example.com/image.jpg?type=TEXT&foo=bar')).toBe(
        'https://example.com/image.jpg?foo=bar'
      );
    });

    it('returns unchanged URL without type=TEXT', () => {
      expect(stripTypeText('https://example.com/image.jpg')).toBe(
        'https://example.com/image.jpg'
      );
    });
  });
});
