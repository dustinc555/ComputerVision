function [P] = makePyramid(img, n)
    s = size(img);
    rowSize = s(1);
    colSize = s(2);
    
    maxRows = rowSize;
    maxCols = colSize;
    
    images = {};
    images{1} = img;
    currImg = img;
    for i = 1 : n
        currImg = impyramid(currImg, 'reduce');
        currS = size(currImg);
        maxCols = maxCols + currS(2);
        images{i+1} = currImg;
    end
    
    o = 1;
    
    if size(img,3)==3
        Q = zeros(maxRows, maxCols, 3, 'uint8');
    else
        Q = zeros(maxRows, maxCols, 'uint8');
    end
    
    for i = 1 : n
        currImg = images{i};
        currS = size(currImg);
        numRows = currS(1);
        numCols = currS(2);
        oEnd = o+numCols-1;
        Q(1:numRows, o:oEnd, :) = currImg(:,:,:);
        o = oEnd;
    end
    
    P = Q;
end