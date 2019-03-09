function [I] = ShowFeatures(I, points, brushSize)
    % overlays rectangles on image
    % I - the image
    % points - is a n by 4 array that contains: [x y theta size]
    % brushSize - line width of the rectangle
    % size - side length of square
    for i = 1 : size(points, 1)
        x = points(i, 1);
        y = points(i, 2);
        theta = points(i, 3);
        s = points(i, 4);
        I = drawRectangle(I, [x y], s, theta, brushSize);
    end
end