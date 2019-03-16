function [F] = drawMatches(I1, I2, matches, brushSize)
    % I1, I2 are unaltered rgb images
    % see matchFeatures for matches
    % it is assumed that the first row of every element
    % of matches come from I1 and the second from I2
    mheight = max([size(I1, 1) size(I2, 1)]);
    width = size(I1, 2) + size(I2, 2);
    
    F = uint8(zeros(mheight, width, 3));
    
    F(1:size(I1, 1), 1:size(I1, 2), :) = I1;
    F(1:size(I2, 1), size(I1, 2)+1:end, :) = I2;
        
    for i = 0 : matches.size() - 1
        pair = matches.get(i);
        x = pair(1, 1);
        y = pair(1, 2);
        endX = pair(2, 1) + size(I1, 2);
        endY = pair(2, 2);
        F = insertShape(F,'line',[x y endX endY],'LineWidth', brushSize);
    end
end