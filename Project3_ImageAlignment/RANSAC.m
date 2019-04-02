function [W, WLEFT, WRIGHT] = RANSAC(I1, I2, n, minThresh)
    %% check n different homography's selected at random

    best_error = inf;
    W = [];
    WRIGHT = [];
    WLEFT = [];
    
    
    %% compute transform and calculate amount of error
    for i = 1 : n
        
       % randomly select 4 points
       [m1, m2] = getCorrespondences_auto(I1, I2, 4);
       
       % warp
       [W_new, WLEFT, WRIGHT] = overlay(I1, I2, m1, m2);
       WLEFT = double(WLEFT);
       WRIGHT = double(WRIGHT);
       
       current_error = getImgDiff(WLEFT, WRIGHT);
       %current_error
       %currentTotal = currentTotal + current_error;
       
       
       % assign max of inliers
       if best_error > current_error %&& minThresh > current_error
          W = W_new; 
       end
    end
    
    WRIGHT = uint8(WRIGHT);
    WLEFT = uint8(WLEFT);    
    
    if (isempty(W))
        error("Could not find a warp allowable with the given threshold.");
    end
end