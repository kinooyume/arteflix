//@ts-check
const fs = require('fs');

// NOTE:  'rescript' + bs-dependencies
const transpileModules = [
  'rescript',
  '@rescript/react',
  '@rescript/core',
  'rescript-schema',
  'rescript-nodejs',
  '@glennsl/rescript-fetch',
  'rescript-swr',
  'ui',
];

// eslint-disable-next-line @typescript-eslint/no-var-requires
const { composePlugins, withNx } = require('@nx/next');
// import { composePlugins, withNx } from '@nx/next';

/**
 * @type {import('@nx/next/plugins/with-nx').WithNxOptions}
 **/
const nextConfig = {
  transpilePackages: transpileModules,
  output: 'standalone',
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'api-cdn.arte.tv',
        pathname: '/img/**',
      },
    ],
    imageSizes: [265, 336, 380, 620],
    deviceSizes: [640, 750, 828, 1080, 1200, 1400, 1920],
  },
  webpack: (config, options) => {
    const { isServer } = options;

    if (!isServer) {
      // We shim fs for things like the blog slugs component
      // where we need fs access in the server-side part
      config.resolve.fallback = {
        fs: false,
        path: false,
      };
    }

    // We need this additional rule to make sure that mjs files are
    // correctly detected within our src/ folder
    config.module.rules.push({
      test: /\.m?js$/,
      use: options.defaultLoaders.babel,
      exclude: /node_modules/,
      type: 'javascript/auto',
      resolve: {
        fullySpecified: false,
      },
    });

    return config;
  },
  nx: {
    // Set this to true if you would like to to use SVGR
    // See: https://github.com/gregberge/svgr
    svgr: false,
  },

  compiler: {
    // NOTE: Disable emotion as it isn't support for now ( due to usage of context )
    // https://github.com/emotion-js/emotion/issues/2928#issuecomment-1293885043

    // Also check: https://github.com/vercel/next.js/issues/41994
    emotion: false,
  },
};

const plugins = [
  // Add more Next.js plugins to this list if needed.
  withNx,
];

module.exports = composePlugins(...plugins)(nextConfig);
