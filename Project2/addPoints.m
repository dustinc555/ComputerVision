function [values] = addPoints(I, bx, by, theta, s)
    % I - the unaltered rgb image
    % bx - start x
    % by - start y
    % theta - feature angle
    % s - scale of feature
    x = bx;
    y = by;
    values = zeros(s, 3);
    for i = 1 : s
        x = x + cos(theta);
        y = y - sin(theta);
        if (x >= 1) && (x <= size(I,1))&& (y >= 1) && (y <= size(I,2))
            pixel = I(floor(x), floor(y), :);
            values(i,:) = [pixel(:,:,1), pixel(:,:,2), pixel(:,:,3)];
        else
            values(i,:) = [0, 0, 0];
        end
    end
end