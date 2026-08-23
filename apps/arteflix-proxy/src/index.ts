import { handle, type Env } from './proxy';

export default {
  fetch: (request, env, ctx) =>
    handle(request, env, caches.default, (promise) => ctx.waitUntil(promise), {
      ip: request.headers.get('CF-Connecting-IP'),
      country: (request.cf?.country as string | undefined) ?? 'XX',
    }),
} satisfies ExportedHandler<Env>;
