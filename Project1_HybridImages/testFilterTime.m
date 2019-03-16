function [T] = testFilterTime(img, n, small, kernel)

    % .25MP = 613 x 408
    % stores time of execution
    Q = zeros(n + 1, 1);
    
    %J = imresize(I,scale)
    %J = imresize(I,[numrows numcols])
    
    filter = fspecial('Gaussian', kernel, 1);
    
    rowSize = size(img, 1);
    colSize = size(img, 2);
    
    qr = small(1);
    qc = small(2);
    
    kr = (rowSize - qr) / n; % amount to decrease rowsize by
    kc = (colSize - qc) / n; % amount to decrease colsize by
    
    
    for i = 1 : (n + 1)
        % run and time filter on image with kernel
        t = cputime;
        imfilter(img, filter); % test this size img with kernel size filter
        e = cputime - t;
        Q(i) = e; % record time
        % shrink imag
        img = imresize(img,[rowSize - kr colSize - kc]);
    end
    T = fliplr(Q); % reverse array
end