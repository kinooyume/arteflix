import { request, fail } from './AssetQueue.bs.mjs';

describe('AssetQueue', () => {
  beforeEach(() => {
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.useRealTimers();
  });

  it('holds every new image for 60s after a failure', () => {
    const first = jest.fn();
    request('https://img/first', 'Low', first);
    jest.advanceTimersByTime(20);
    expect(first).toHaveBeenCalled();

    fail('https://img/first');

    const second = jest.fn();
    request('https://img/second', 'High', second);
    jest.advanceTimersByTime(59000);
    expect(second).not.toHaveBeenCalled();

    jest.advanceTimersByTime(1000);
    expect(second).toHaveBeenCalled();
  });
});
