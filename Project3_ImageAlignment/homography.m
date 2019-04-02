function [H] = homography(m1, m2)
    % construct homography counting m2 as original x
    % and m1 as x'
    
    n = size(m1, 1);
    A = constructA(m1, m2); % get A matrix from m values 
    
    if n == 4
       H = null(A); 
    else
       [U, S, V] = svd(A);
       H = V(:, 9);
    end
    
    H = reshape(H, 3, 3)'; % get matrix
    H = H ./ H(3,3);       % normalize
end