function [S] = SSD(v1, v2)
    % f1 and f2 are EQUAL nx3 matrices
    % that are image features rotated for 
    % rotation invarience and also scale invarient as well
    
    maxI = min([size(v1, 1) size(v2, 1)]);
    
    S = 0;
        
    if size(v1,2) == 3 && size(v2,2) == 3
        for i = 1 : maxI
            S = S + sqrt( (v2(i,1) - v1(i,1))^2 + (v2(i,2) - v1(i,2))^2 + (v2(i,3) - v1(i,3))^2 );
        end
    else
        S = 0;
    end
    
end