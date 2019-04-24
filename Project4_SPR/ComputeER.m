function [optimalK, K] = ComputeER(X, U, S, thresh)
    X = double(X);
    
    names = getTestSetNames();
    
    Xf = norm(X, 'fro');
    Xfsq = Xf.^2;
    Ssq = S.^2;
    
    optimalK = 0;
    K = [];
    
    p = 0;
    notFound = true;
    for k = 1 : 128
        p = p + Ssq(k,k)/Xfsq;
        
        K = [K ; p];
        
        if ( p > thresh && notFound )
            optimalK = k;
            notFound = false;
        end
    end
end