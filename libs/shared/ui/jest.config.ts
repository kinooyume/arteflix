export default {
  displayName: 'ui',
  preset: '../../../jest.preset.js',
  testEnvironment: 'jest-environment-jsdom',
  transform: {
    '^.+\\.mjs$': ['babel-jest', { presets: ['@nx/react/babel'] }],
    '^(?!.*\\.(js|jsx|ts|tsx|css|json|mjs)$)': '@nx/react/plugins/jest',
    '^.+\\.[tj]sx?$': ['babel-jest', { presets: ['@nx/react/babel'] }],
  },
  transformIgnorePatterns: [
    'node_modules/(?!(rescript|@rescript/core|sury|caml_.*)/)',
  ],
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'mjs'],
  coverageDirectory: '../../../coverage/libs/shared/ui',
};
