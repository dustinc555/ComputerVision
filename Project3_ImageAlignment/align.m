function [W, WLEFT, WRIGHT] = align(I1, I2, mode)
    %% set parameters
    % if mode is auto, this is how many times 
    % to RANSAC the homography
    trials = 100;
    
    % max distance the warped image can be from the 
    % image being warped to
    allowed_image_error = realmax;
    
    % 1 -> 100% error in point mapping
    % the error can be high and still fairly accurate if the image is large
    % having too small of a number may cause the algorithm to not find
    % acceptable warps
    allowed_maping_error = 15;
    
    %% act on mode
    if mode == 'a'
        % get a few random matches
        tic 
        [W, WLEFT, WRIGHT] = RANSAC(I1, I2, trials, allowed_image_error, allowed_maping_error); % returns the better match
        toc
    else
        [m1, m2] = getCorrespondences_manual(I1, I2, 4);
        [W, WLEFT, WRIGHT] = overlay(I1, I2, m1, m2, allowed_maping_error, mode);
    end
    %% correct triangular gaps in image 
    W = fillGaps(W); % attempt to fill holes left by transform
end