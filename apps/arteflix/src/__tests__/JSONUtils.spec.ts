import { stripUndefined } from '../res/JSONUtils.bs.mjs';

describe('JSONUtils', () => {
  describe('stripUndefined', () => {
    it('strips undefined values from an object', () => {
      const input = { a: 1, b: undefined, c: 'hello' };
      const result = stripUndefined(input);
      expect(result).toEqual({ a: 1, c: 'hello' });
      expect(result).not.toHaveProperty('b');
    });

    it('preserves null values', () => {
      const input = { a: null, b: 'test' };
      expect(stripUndefined(input)).toEqual({ a: null, b: 'test' });
    });

    it('handles nested objects with undefined values', () => {
      const input = { a: { b: 1, c: undefined }, d: 'ok' };
      expect(stripUndefined(input)).toEqual({ a: { b: 1 }, d: 'ok' });
    });

    it('handles arrays', () => {
      const input = [1, 2, 3];
      expect(stripUndefined(input)).toEqual([1, 2, 3]);
    });

    it('handles empty object', () => {
      expect(stripUndefined({})).toEqual({});
    });

    it('handles empty array', () => {
      expect(stripUndefined([])).toEqual([]);
    });

    it('preserves strings, numbers, and booleans', () => {
      expect(stripUndefined('hello')).toBe('hello');
      expect(stripUndefined(42)).toBe(42);
      expect(stripUndefined(true)).toBe(true);
    });
  });
});
