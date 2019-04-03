function [F] = fillGaps(I)
    g = fspecial('gaussian', 100, 100);
    BW = (I(:,:,1) == 0) & (I(:,:,2) == 0) & (I(:,:,3) == 0);
    F(:,:,1) = roifilt2(g, I(:,:,1), BW);
    F(:,:,2) = roifilt2(g, I(:,:,2), BW);
    F(:,:,3) = roifilt2(g, I(:,:,3), BW);
end