function [W, WLEFT, WRIGHT] = align(I1, I2, mode)
    % get image features to base warping on

    if mode == 'a'
        % get a few random matches
        tic 
        [W, WLEFT, WRIGHT] = RANSAC(I1, I2, 50, intmax); % returns the better match
        toc
    else
        [m1, m2] = getCorrespondences_manual(I1, I2, 4);
        [W, WLEFT, WRIGHT] = overlay(I1, I2, m1, m2);
    end
end