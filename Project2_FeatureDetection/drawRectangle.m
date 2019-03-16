function [I] = drawRectangle(I, p, size, theta, brushSize)
    % draws a rectangle on an image with a x y point, size, and brushSize
    points = zeros(4, 2);
    h = size / sqrt(2);
    xc = p(1);
    yc = p(2);
    for i = 0 : 3
        % start at 45 degrees, add 90 degrees for square corner
        % add theta for offset
        x = ceil(xc + h * cos((pi/4) + (pi/2) * i + theta));
        y = ceil(yc - h * sin((pi/4) + (pi/2) * i + theta));
        points(i+1,:) = [x y];
    end
        
    % now draw the points
    for i = 1 : 3
        x = points(i,1);
        y = points(i,2);
        endX = points(i + 1,1);
        endY = points(i + 1,2);
        I = insertShape(I,'line',[x y endX endY],'LineWidth', brushSize, 'color', 'red');
    end
    
    % connect the last two
    x = points(1,1);
    y = points(1,2);
    endX = points(end,1);
    endY = points(end,2);
    I = insertShape(I,'line',[x y endX endY],'LineWidth', brushSize, 'color', 'red');
    
    % draw direction pointer line for orientation 
    endX = xc + (size/2)*cos(theta);
    endY = yc - (size/2)*sin(theta);
    I = insertShape(I,'line',[xc yc endX endY],'LineWidth', brushSize, 'color', 'blue');
end