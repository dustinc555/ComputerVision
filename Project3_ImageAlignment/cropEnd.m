function [C] = cropEnd(I)
% this function scans the columns of I from right to left and crops the
% moment it encounters a none zero pixel

    for x = size(I,2):-1:1
        for y = size(I, 1):-1:1 
            if any(I(y,x,:))
               C = imcrop(I,[1 1 x y]);
               return;
            end
        end
    end
    C = I;
end