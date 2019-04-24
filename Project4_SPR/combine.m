function [Um] = combine(Images, Favg)
    Um = zeros(size(Images{1}, 1), length(Images));
    for i = 1 : length(Images)
        Um(:, i) = Images{i} - Favg;
    end
end