function [T] = testRunner(img, n, small, maxKernel)
    C = {}; % store tests here
    % every test returned by testFilterImg
    % will be a 1d time elapsed array from large img to small
    % run testFilterTime for 1x1 to maxKernel
    for i = 1 : maxKernel(1)
        for j = 1 : maxKernel(2)
            C{(i - 1) * maxKernel(1) + j} = testFilterTime(img, n, small, [i j] );
        end
    end
    T = C;
end