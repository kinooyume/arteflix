const [base = 'https://arteflix.kinoo.dev', origin = 'https://arteflix.kinoo.dev'] = process.argv.slice(2);

const ARTE_CDN = 'https://api-cdn.arte.tv/api/emac/v4/fr/web';
const LIVE_COUNTRIES = ['FR', 'DE'];
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

const callerCountry = async () => {
  const trace = await (await fetch('https://www.cloudflare.com/cdn-cgi/trace')).text();
  return trace.match(/^loc=(\w+)$/m)?.[1];
};

const verifyPlayer = async (label, path, { expectStreams = true } = {}) => {
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
    `${label} geolocated as the caller`,
    geo?.userCountryCode === country,
    `arte saw ${geo?.userCountryCode ?? '?'}, caller is ${country}`
  );
  if (expectStreams) {
    check(
      `${label} has a stream`,
      streams.length > 0,
      `${streams.length} streams${arteError ? `, ${arteError}` : ''}`
    );
  } else {
    check(`${label} geoblocked outside FR/DE`, arteError === 'ERROR_GEOLOCATION', arteError ?? 'no error');
  }
  if (warnings.length) console.log(`     warnings: ${warnings.map((w) => w.code).join(', ')}`);

  if (streams[0]?.url) {
    const manifest = await fetch(streams[0].url);
    check(`${label} manifest reachable from here`, manifest.ok, `${manifest.status}`);
  }

  await pause(1000);
  const second = await probe(path);
  check(`${label} cached`, second.res.headers.get('x-proxy-cache') === 'HIT', second.res.headers.get('x-proxy-cache') ?? 'missing');
};

const country = await callerCountry();
console.log(`verifying ${base} as ${origin} from ${country}\n`);

await verifyPlayer('player LIVE', '/proxy/api/fr/player/LIVE', {
  expectStreams: LIVE_COUNTRIES.includes(country),
});

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
