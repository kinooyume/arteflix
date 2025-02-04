import '../styles/main.css';
import MainLayout from '../res/layouts/MainLayout.bs.mjs';
import EmotionRootStyleRegistry from './EmotionRootStyleRegistry';

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <MainLayout>
      <EmotionRootStyleRegistry>{children}</EmotionRootStyleRegistry>
    </MainLayout>
  );
}
