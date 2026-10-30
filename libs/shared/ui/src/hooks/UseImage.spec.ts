import { act, renderHook } from '@testing-library/react';
import { useImage } from './UseImage.bs.mjs';

describe('useImage', () => {
  beforeEach(() => {
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.useRealTimers();
  });

  it('is loaded once the image reports a real width', () => {
    const { result } = renderHook(() => useImage('https://img/a'));
    expect(result.current[0]).toBe('Loading');

    act(() => result.current[1](620));
    expect(result.current[0]).toBe('Loaded');
  });

  it('treats a tiny image as a failure', () => {
    const { result } = renderHook(() => useImage('https://img/a'));

    act(() => result.current[1](40));
    expect(result.current[0]).toBe('Failed');
  });

  it('retries a failed image once, after 60s', () => {
    const { result } = renderHook(() => useImage('https://img/a'));

    act(() => result.current[2]());
    act(() => jest.advanceTimersByTime(59000));
    expect(result.current[0]).toBe('Failed');

    act(() => jest.advanceTimersByTime(1000));
    expect(result.current[0]).toBe('Loading');

    act(() => result.current[2]());
    act(() => jest.advanceTimersByTime(120000));
    expect(result.current[0]).toBe('Failed');
  });

  it('starts over when the source changes', () => {
    const { result, rerender } = renderHook(({ src }) => useImage(src), {
      initialProps: { src: 'https://img/a' },
    });

    act(() => result.current[2]());
    rerender({ src: 'https://img/b' });
    expect(result.current[0]).toBe('Loading');
  });
});
