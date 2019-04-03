function [W, WLEFT, WRIGHT, valid] = overlay(I1, I2, m1, m2)
    %% get homography for warping m2 with respect to m1 space
    H = homography(m1, m2);
    W = [];
    WLEFT = [];
    WRIGHT = [];
    valid = true;
    
    %% validate homography
    % m2 points should transform acceptably close to m1 points
    allowed_error = 20;
    
    x1 = double([m2(1, :)' ; 1]);
    x2 = double([m2(1, :)' ; 1]);
    
    % transform points
    x1 = H * x1;
    x2 = H * x2;
    
    % see if they are within the allowable error
    % if there is a difference above the threshold, abandon this
    % transform.
    x1_prime = double([m1(1, :)' ; 1]);
    x2_prime = double([m1(1, :)' ; 1]);
    valid = (~any(abs((x1 - x1_prime) ./ 2) > allowed_error)) && (~any(abs((x2 - x2_prime) ./ 2) > allowed_error));
    
    if (~valid)
        return;
    end
    %% make enlarged image plane W to overlay images onto
    w_height = max(size(I1, 1), size(I2, 1));
    w_width = max( size(I1, 2), size(I2, 2));
    widthLimit = int32(1.2 * w_width);
    heightLimit = w_height;
    W = uint8(zeros(heightLimit, widthLimit, 3));
        
    % WRIGHT will be only the warping of I2 to I1
    WRIGHT = W;
    
    
    % overlay I1
    W(1:size(I1,1), 1:size(I1,2), :) = I1;
        
    % WLEFT is I1 enlarged
    WLEFT = W;
   
    
    %% overlay I2 with respect to I1 onto WRIGHT and W
    for y = 1 : size(I2, 1)
       for x = 1 : size(I2, 2)
           v = [x ; y ; 1];
           v_t = int32(H * v); % transform
           if (v_t(1) > 0) && (v_t(2) > 0) && (v_t(1) < widthLimit) && (v_t(2) < heightLimit) && (v_t(1) < widthLimit) && (v_t(2) < heightLimit)
                WRIGHT(v_t(2), v_t(1), :) = I2(y, x, :);
                W(v_t(2), v_t(1), :) = I2(y, x, :);
           elseif (v_t(1) > widthLimit) && (v_t(2) > heightLimit)
               % if the warp escapes the limit, return two polar oposite
               % images 
               valid = false;
               return;
           end
       end
    end
    
    WLEFT = padarray(WLEFT, [size(WRIGHT, 1) - size(WLEFT, 1) size(WRIGHT, 2) - size(WLEFT, 2)], 0, 'post');
end