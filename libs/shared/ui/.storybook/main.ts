import react from '@vitejs/plugin-react';
import type { StorybookConfig } from '@storybook/react-vite';
import { mergeConfig } from 'vite';
import { loadCsf } from '@storybook/csf-tools';

import { nxViteTsPaths } from '@nx/vite/plugins/nx-tsconfig-paths.plugin';

import { Indexer, IndexerOptions, IndexInput } from 'storybook/internal/types';
import { readFileSync } from 'node:fs';

const storyFileRegex = /^(.*)Stories\.bs\.mjs$/;

const rescriptIndexer = async (
  fileName: string,
  opts: IndexerOptions,
): Promise<IndexInput[]> => {
  const code = readFileSync(fileName, 'utf-8');
  const csf = loadCsf(code, { ...opts, fileName }).parse();

  return csf.indexInputs;
};

const config: StorybookConfig = {
  stories: [
    '../src/components/**/*.@(mdx|stories.@(js|jsx|ts|tsx))',
    '../src/components/**/*Stories.bs.@(mjs)',
    '../src/**/*.custom-stories.@(js|jsx|ts|tsx)',
  ],

  experimental_indexers: async (existingIndexers) => {
    const customIndexer = {
      test: storyFileRegex,
      createIndex: rescriptIndexer,
    };

    return [...(existingIndexers || []), customIndexer];
  },
  //
  addons: ['@storybook/addon-essentials', '@storybook/addon-interactions'],
  framework: {
    name: '@storybook/react-vite',
    options: {},
  },

  viteFinal: async (config) =>
    mergeConfig(config, {
      plugins: [react(), nxViteTsPaths()],
    }),
};

export default config;

// To customize your Vite configuration you can use the viteFinal field.
// Check https://storybook.js.org/docs/react/builders/vite#configuration
// and https://nx.dev/recipes/storybook/custom-builder-configs
