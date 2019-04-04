function [D] = getImgDiff(I1, I2)
    D = sum(sum(sum(imabsdiff(I1, I2))));
end