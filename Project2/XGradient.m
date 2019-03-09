function [G] = XGradient(kernel)
    kernel([1 2]) = kernel([2 1]);
    G = transpose(YGradient(kernel));
end