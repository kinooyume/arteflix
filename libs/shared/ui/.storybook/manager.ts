import { addons } from '@storybook/manager-api';
import { themes } from '@storybook/theming';

addons.setConfig({
  theme: {
    ...themes.dark,
    brandTitle: 'Arteflix UI',
    brandUrl: 'https://arteflix.kinoo.dev',
    colorPrimary: '#e50914',
    colorSecondary: '#e50914',
  },
});
