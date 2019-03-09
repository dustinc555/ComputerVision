function [dogList] = DoG(I, baseSigma)
    I = rgb2gray(I);
    % I - the image
    % baseSigma - for gaussian multiplied by 2 per filter
    % returns a 3d matrix of the difference of gaussians, IxIx4 - for 4
    % DoGs
    
    gaussianList = java.util.ArrayList();

    % convolve image with gaussians
    % increasing sigma per index by 2
    for i = 1 : 5
        g = fspecial('gaussian', [25, 25], baseSigma);
        newG = imfilter(I, g);
        gaussianList.add(newG);
        baseSigma = baseSigma * 2;
    end
    
    
    %A = [];
    %for i = 0 : gaussianList.size() - 1
    %    A = [A gaussianList.get(i)];
    %end
    %imshow(A);
    
    % compute difference of gaussian array
    dogList = zeros(size(I, 1), size(I,2), 3);
   
    for i = 0 : gaussianList.size() - 2
        dogList(:, :, i + 1) = gaussianList.get(i) - gaussianList.get(i + 1);
    end
    
    
    
    %A = [];
    %for i = 0 : dogList.size() - 1
    %    A = [A dogList.get(i)];
    %end
    %imshow(A);
    
end