function [D] = decimate(I, n)
    D = I(1:n:end, 1:n:end, :);
end