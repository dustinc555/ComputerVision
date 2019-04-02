function [m1, m2] = getCorrespondences_auto(I1, I2, n)
    % this functions purpose is to reutrn n matching features
    % from image I1 and I2 automatically using harris corner detection
    % return: m1, m2 both n by 2 matrices [x y ; x2 y2 ...]
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
    
    I1Points = detectHarrisFeatures(I1);
    I2Points = detectHarrisFeatures(I2);
    
    [I1Features, I1ValidPoints] = extractFeatures(I1, I1Points);
    [I2Features, I2ValidPoints] = extractFeatures(I2, I2Points);
    
    indexPairs = matchFeatures(I1Features, I2Features);
    
    % get location with
    % matchedPoints(index).Location(1 or 2)
    matchedPoints1 = I1ValidPoints(indexPairs(:,1),:);
    matchedPoints2 = I2ValidPoints(indexPairs(:,2),:);
    
    % randperm(n, k)
    % returns a row vector containing k unique integers from 1 to n
    if (size(matchedPoints1, 1) < 4)
       error('Could not detect enough features...'); 
    end
    p = randperm(size(matchedPoints1, 1), n);
    
    m1 = matchedPoints1(p).Location;
    m2 = matchedPoints2(p).Location;
end