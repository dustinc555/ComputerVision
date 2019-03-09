function [L] = drawLine(I, p, l, theta, stroke)
    x = p(1);
    y = p(2);
    endX = x + l * cos(theta);
    endY = y - l * sin(theta);
    L = insertShape(I,'line',[x y endX endY],'LineWidth',stroke, 'color', 'red');
end