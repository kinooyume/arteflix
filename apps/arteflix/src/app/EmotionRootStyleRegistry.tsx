'use client';

import { cache } from '@emotion/css';
import { CacheProvider } from '@emotion/react';
import { useServerInsertedHTML } from 'next/navigation';
import { useRef } from 'react';

export default function EmotionRootStyleRegistry({
  children,
}: {
  children: React.ReactNode;
}) {
  const flushedRef = useRef(new Set<string>());

  useServerInsertedHTML(() => {
    const entries = Object.entries(cache.inserted);
    const newEntries = entries.filter(([key]) => !flushedRef.current.has(key));
    if (newEntries.length === 0) return null;

    const names: string[] = [];
    let styles = '';
    for (const [key, value] of newEntries) {
      flushedRef.current.add(key);
      if (typeof value === 'string') {
        names.push(key);
        styles += value;
      }
    }

    if (styles.length === 0) return null;

    return (
      <style
        data-emotion={`${cache.key} ${names.join(' ')}`}
        dangerouslySetInnerHTML={{ __html: styles }}
      />
    );
  });

  return <CacheProvider value={cache}>{children}</CacheProvider>;
}
