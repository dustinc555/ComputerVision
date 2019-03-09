function [P] = H_detectFeatures(I, alpha, thresh, returnVal)
    % Returns a set of x y theta 
    % points of distinct image features
    % This function is for a singular level
    % for harris detection with sigma see: harrisDetection
    % returnVal - 'img' for img, 'p' for points
    
    % save original for display purposes
    O = I;
    I = rgb2gray(I);
    I = im2double(I);
   
    
    dKernel = [3 3];

    Ix = imfilter(I, XGradient(dKernel), 'conv');
    Iy = imfilter(I, YGradient(dKernel), 'conv');
    
    % get Ixy
    Ixy = Ix .* Iy;
    
    % square them
    Ix = Ix .* Ix;
    Iy = Iy .* Iy;
    Ixy = Ixy .* Ixy;
    
    % convolve with gaussian filter
    g = fspecial('Gaussian', [60 60]);
    
    Ix = imfilter(Ix, g, 'conv');
    Iy = imfilter(Iy, g, 'conv');
    Ixy = imfilter(Ixy, g, 'conv');
    
    
    % Harris corner detection 
    % we want points that are strong in both Ix and Iy
    % these are corners and they are good candidates for
    % describing an image
    F = Ix .* Iy - (Ixy .* Ixy);
    F = F - alpha .* ((Ix + Iy) .* (Ix + Iy));
    
    % threshold image by user threshold
    for point = find(F < thresh)
        F(point) = 0;
    end    
    
    
    % blob detect with laplacian
    %lFilter = fspecial('laplacian', .1);
    %L = imfilter(I, lFilter);
    %F = F .* L;
    
    % select local maximas
    windowSize = 3;
    maximum = windowSize^2;
    maxes = ordfilt2(F, maximum, ones(windowSize, windowSize));
    thresh = (mean(maxes) + max(maxes)) / 2;
    corners = (F == maxes) & (maxes > thresh);
    
    % get corners, their gradients, and the size
    IND = find(corners);
    [Y, X] = ind2sub(size(corners), IND);
    P = [X Y];
    gradients = double(zeros(size(Y)));
    
    for i = 1 : size(Y)
        y = Y(i);
        x = X(i);
        gradients(i) = atan((Iy(y, x) / Ix(y, x)));
    end
    
    
    % if returnVal is p, return the points with orientation array
    % else return a visual 
    if strcmp(returnVal, 'p')
        P = [P gradients];
    else
       [p,q] = size(maxes);
       P = zeros(p, q*2);
       P(1:p, 1:q) = I;
       P(1:p, q+1:end) = corners;
    end
end