function [vectors] = convertToVectors(I, F, s)
    % takes an image I and a set of features F
    % Returns: a java arraylist where every index contains a size by 3
    % matrix. This matrix is the pixel values of the image at this feature 
    % made invarient to rotation by ordering the pixels
    vectors = java.util.ArrayList();
    for i = 1 : size(F, 1)
        % x y size theta
        xc = F(i, 1);
        yc = F(i, 2);
        %s = floor(F(i, 3)); no
        theta = F(i,4);
        vectors.add( convertFeature(I, xc, yc, theta, s) );
    end
end