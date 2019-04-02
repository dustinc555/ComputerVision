function [m1, m2] = getCorrespondences_manual(I1, I2, n)
    % this functions purpose is to reutrn n matching features
    % from image I1 and I2 manually with input from the user.
    % return: m1, m2 both n by 2 matrices [x y ; x2 y2 ...]

    points = java.util.ArrayList;
    
    m1 = zeros(n, 2);
    m2 = zeros(n, 2);
   
    for i = 1 : n
        p = [-1, -1 ; -1, -1];
        while (~(all(p >= 0)))
            imshow(I1);
            p1 = ginput(1);
            close all;
            imshow(I2);
            p2 = ginput(1);
            close all;
            p = [p1 ; p2];
            m1(i, :) = p1;
            m2(i, :) = p2;
            if (~(all(p >= 0))) 
                msgbox("Click within the image please.");
            end
        end
        points.add(p); % append
    end
    close all;
end