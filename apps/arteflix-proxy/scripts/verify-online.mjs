const [base = 'https://arteflix.kinoo.dev', origin = 'https://arteflix.kinoo.dev'] = process.argv.slice(2);

const ARTE_CDN = 'https://api-cdn.arte.tv/api/emac/v4/fr/web';
const pause = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

let failures = 0;
const check = (label, ok, detail = '') => {
  if (!ok) failures++;
  console.log(`${ok ? 'ok  ' : 'FAIL'} ${label}${detail ? ` — ${detail}` : ''}`);
};

const firstTrailerId = async () => {
  const page = await (await fetch(`${ARTE_CDN}/pages/HOME?bypassESI=true`)).json();
  for (const zone of page.zones.slice(0, 6)) {
    await pause(1000);
    const res = await fetch(`${ARTE_CDN}/zones/${zone.id}/content?bypassESI=true&page=1`);
    if (!res.ok) continue;
    const item = (await res.json()).data.find((i) => i.trailer?.id);
    if (item) return item.programId ?? item.id;
  }
};

const probe = async (path) => {
  const url = `${base}${path}`;
  const res = await fetch(url, { headers: { Origin: origin } });
  const text = await res.text();
  let json;
  try {
    json = JSON.parse(text);
  } catch {
    json = undefined;
  }
  return { res, text, json };
};

const verifyPlayer = async (label, path) => {
  const first = await probe(path);
  check(`${label} status`, first.res.status === 200, `${first.res.status} ${first.text.slice(0, 120)}`);
  check(`${label} valid json`, first.json !== undefined);
  check(
    `${label} cors`,
    first.res.headers.get('access-control-allow-origin') === origin,
    first.res.headers.get('access-control-allow-origin') ?? 'missing'
  );

  const streams = first.json?.attributes?.streams ?? [];
  const warnings = first.json?.attributes?.warnings ?? [];
  const geo = first.json?.attributes?.restriction?.geoblocking;
  const arteError = first.json?.attributes?.error?.code;
  check(
    `${label} has a stream`,
    streams.length > 0,
    `${streams.length} streams, seen by arte from ${geo?.userCountryCode ?? '?'}${arteError ? `, ${arteError}` : ''}`
  );
  if (warnings.length) console.log(`     warnings: ${warnings.map((w) => w.code).join(', ')}`);

  if (streams[0]?.url) {
    const manifest = await fetch(streams[0].url);
    check(`${label} manifest reachable from here`, manifest.ok, `${manifest.status}`);
  }

  await pause(1000);
  const second = await probe(path);
  check(`${label} cached`, second.res.headers.get('x-proxy-cache') === 'HIT', second.res.headers.get('x-proxy-cache') ?? 'missing');
};

console.log(`verifying ${base} as ${origin}\n`);

await verifyPlayer('player LIVE', '/proxy/api/fr/player/LIVE');

const trailerId = await firstTrailerId();
if (trailerId) {
  await pause(1000);
  await verifyPlayer(`trailer ${trailerId}`, `/proxy/api/fr/trailer/${trailerId}`);
} else {
  check('found a trailer id on HOME', false);
}

const preflight = await fetch(`${base}/proxy/api/fr/player/LIVE`, {
  method: 'OPTIONS',
  headers: { Origin: origin, 'Access-Control-Request-Method': 'GET' },
});
check('preflight', preflight.status === 204, `${preflight.status}`);

console.log(failures ? `\n${failures} check(s) failed` : '\nall checks passed');
process.exit(failures ? 1 : 0);
