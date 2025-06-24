// routes/lazyLoad.tsx
import React, {Suspense, type ReactNode, type JSX} from 'react';

const lazyLoad = (Comp: React.LazyExoticComponent<() => JSX.Element>): ReactNode => {
    return (
        <Suspense fallback={<div>Loading...</div>}>
            <Comp />
        </Suspense>
    );
};

export default lazyLoad;