function [F] = my_gaussfilter(img, sigma, highPass)
 
    s = size(img);
    numRows = s(1);
    numCols = s(2); 

    G = normalize(fspecial('gaussian', [numRows, numCols], sigma), 'range');
    
    if (highPass)
        G = 1 - G;
    end
    F = G;
end