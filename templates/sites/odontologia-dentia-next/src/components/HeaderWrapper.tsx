'use client';

import { usePathname } from 'next/navigation';
import Header from './Header';

export default function HeaderWrapper() {
  const pathname = usePathname();

  let headerClass = "transparent scroll-light";
  let useHeaderInner = false;
  const isHomepage = pathname === '/' || pathname.startsWith('/homepage-');

  if (pathname === '/homepage-2') {
    headerClass = "transparent header-light";
  } else if (pathname === '/homepage-6') {
    headerClass = "transparent header-light";
  } else if (pathname === '/homepage-5') {
    headerClass = "transparent header-light nav-up";
  } else if (pathname === '/homepage-3' || pathname === '/homepage-7') {
    headerClass = "transparent header-light header-float";
    useHeaderInner = true;
  } else if (!isHomepage) {
    headerClass = "transparent header-light";
  }

  return <Header className={headerClass} useHeaderInner={useHeaderInner} />;
}
