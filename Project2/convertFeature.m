function [V] = convertFeature(I, xc, yc, theta, s)
    % takes a features location, angle and scale 
    % and orders every pixel into a s^2x3 array
    % where every rows values represent the intensities of:
    % 1 -> R, 2 -> G, 3 -> B
    % Params:
    % I - the original un altered image
    % xc - feature x location
    % yc - feature y location
    % theta - feature angle
    % s - feature scale
    
    V = zeros(s^2, 3);
    h = s / sqrt(2);
    x = xc + h * cos(135 + theta);
    y = yc + h * sin(135 + theta);
    
    for i = 0 : s - 1
        x = x + cos(270 + theta);
        y = y - sin(270 + theta);
        V(i*s+1 : i*s+s, :) = addPoints(I, floor(x), floor(y), theta, s);
    end
end