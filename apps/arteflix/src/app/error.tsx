'use client';

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  console.error('[error.tsx]', error);
  return (
    <div style={{ padding: '2rem', color: 'white', fontFamily: 'monospace' }}>
      <h2>Something went wrong</h2>
      <pre style={{ whiteSpace: 'pre-wrap', color: '#ff6b6b' }}>
        {error.message}
      </pre>
      <pre style={{ whiteSpace: 'pre-wrap', color: '#888', fontSize: '12px' }}>
        {error.stack}
      </pre>
      <button onClick={reset} style={{ marginTop: '1rem', padding: '8px 16px' }}>
        Retry
      </button>
    </div>
  );
}
