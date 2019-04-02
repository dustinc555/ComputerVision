function [A] = constructA(m1, m2)
    n = size(m2, 1); % n should equal 4
    
    A = zeros(n * 2, 9);
    % step 1: compute A
    % think of m1 as x and m2 as x'
    
    % construct A matrix
    for i = 1 : n
       x = m2(i, 1);
       y = m2(i, 2);
       x_prime = m1(i, 1);
       y_prime = m1(i, 2);
       A(2*i-1,:) = [x y 1 0 0 0 -x * x_prime -x_prime*y -x_prime]; 
       A(2*i,:) = [0 0 0 x y 1 -y_prime*x -y_prime*y -y_prime]; 
    end
end