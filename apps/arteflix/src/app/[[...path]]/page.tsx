import { make as AppRouter } from '../../res/AppRouter.bs.mjs';

export const dynamicParams = false;

export function generateStaticParams() {
  return [{ path: [] }];
}

export const metadata = {
  title: 'Arteflix',
  description: 'Arte with Netflix UI',
};

export default function Page() {
  return <AppRouter />;
}
