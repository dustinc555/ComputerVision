function [G] = YGradient(kernel)
    % most negative at top, most positive at bottom,
    % zero at center.
    % ex: kernel = [3, 3] returns [-1 -1 -1 ; 0 0 0 ; 1 1 1]
    height = kernel(1);
    width = kernel(2);
    center = ceil(height / 2);
    G = zeros(height, width);
    for i = 1 : height
        for j = 1 : width
            G(i, j) = i - center;
        end
    end
end