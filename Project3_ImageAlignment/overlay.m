function [W, WLEFT, WRIGHT] = overlay(I1, I2, m1, m2)
    %% get homography for warping m2 with respect to m1 space
    H = homography(m1, m2);

    %% make enlarged image plane W to overlay images onto
    w_height = max(size(I1, 1), size(I2, 1));
    w_width = max( size(I1, 2), size(I2, 2));
    W = uint8(zeros(w_height, w_width, 3));
        
    % WRIGHT will be only the warping of I2 to I1
    WRIGHT = W;
    
    
    % overlay I1
    W(1:size(I1,1), 1:size(I1,2), :) = I1;
        
    % WLEFT is I1 enlarged
    WLEFT = W;
    
    widthLimit = 2 * size(WLEFT, 2);
    heightLimit = w_height;
   
    
    %% overlay I2 with respect to I1 onto WRIGHT and W
    for y = 1 : size(I2, 1)
       for x = 1 : size(I2, 2)
           v = [x ; y ; 1];
           v_t = int32(H * v); % transform
           if (v_t(1) > 0) && (v_t(2) > 0) && (v_t(1) < widthLimit) && (v_t(2) < heightLimit)
                WRIGHT(v_t(2), v_t(1), :) = I2(y, x, :);
                W(v_t(2), v_t(1), :) = I2(y, x, :);
           end
       end
    end
    
    WLEFT = padarray(WLEFT, [size(WRIGHT, 1) - size(WLEFT, 1) size(WRIGHT, 2) - size(WLEFT, 2)], 0, 'post');
end