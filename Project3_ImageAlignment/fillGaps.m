function [F] = fillGaps(I)
    g = fspecial('gaussian', 50);
    BW = (I(:,:,1) == 0) & (I(:,:,2) == 0) & (I(:,:,3) == 0); % get points of zero areas
    F(:,:,1) = roifilt2(g, I(:,:,1), BW); %filter r
    F(:,:,2) = roifilt2(g, I(:,:,2), BW); % filter g
    F(:,:,3) = roifilt2(g, I(:,:,3), BW); % filter b
end