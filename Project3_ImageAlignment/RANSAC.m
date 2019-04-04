function [W, WLEFT, WRIGHT] = RANSAC(I1, I2, n, allowed_image_error, allowed_mapping_error)
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
       [W_new, WLEFT, WRIGHT, valid, current_error] = overlay(I1, I2, m1, m2, allowed_mapping_error, 'a');
       
       if valid
           WLEFT = double(WLEFT);
           WRIGHT = double(WRIGHT);

           current_error = getImgDiff(WLEFT, WRIGHT);

           % assign max of inliers
           if best_error > current_error && allowed_image_error > current_error
              W = W_new; 
              best_error = current_error;
           end
       end
    end
    
    WRIGHT = uint8(WRIGHT);
    WLEFT = uint8(WLEFT);    
    
    if (isempty(W))
        error("Could not find a warp allowable within the thresholds.");
    end
end