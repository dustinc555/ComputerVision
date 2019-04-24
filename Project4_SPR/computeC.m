function [C, U] = computeC(Xhat)
    [U, S, V] = svd(Xhat);
    C = U * (S.^2) * transpose(U);
end