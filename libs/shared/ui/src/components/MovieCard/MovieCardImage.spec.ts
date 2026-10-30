import { sizeByOrientation } from './MovieCardImage.bs.mjs';

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
