import { extractProgramId } from '../domain/ArteUtils.bs.mjs';

describe('extractProgramId', () => {
  it('returns programId when present', () => {
    const item = { programId: '106711-000-A', id: '106711-000-A_fr' };
    expect(extractProgramId(item, 'fr')).toBe('106711-000-A');
  });

  it('extracts id without lang suffix when programId is missing', () => {
    const item = { programId: undefined, id: '106711-000-A_fr' };
    expect(extractProgramId(item, 'fr')).toBe('106711-000-A');
  });

  it('handles longer language codes', () => {
    const item = { programId: undefined, id: '106711-000-A_de' };
    expect(extractProgramId(item, 'de')).toBe('106711-000-A');
  });
});
