function [interestPoints] = harrisDetection(I, baseSigma, maxBoxSize, thresh)
    % returns a set of points where each
    % row is x y size theta
    % I - The image
    % baseSigma - steps to 10% image size from 100%
    % maxBoxSize - the largest size of a box, gets doubled twice per
    % scale
    % thresh - increase to get less features, lower to get more
    
    O = I;
    maxY = size(I, 1);
    maxX = size(I, 2);
    
    % 3d matrix where an interest point on the image corresponds to an
    % index in this matrix A(x, y, :) where : is a size 3 matrix of Value,
    % theta, size
    interestPointsMatrix = zeros(maxY, maxX, 3);
    
    % do harris corner detection to get points of interest
    boxSize = maxBoxSize;
   
    interestPointsList = H_detectFeatures(I, .005, thresh, 'p');
   
    interestPointsList(:,4) = boxSize;
        
    for j = 1 : size(interestPointsList, 1)
            x = interestPointsList(j, 1);
            y = interestPointsList(j, 2);
            % flag interest point at image location 
            interestPointsMatrix(y, x, :) = [1 interestPointsList(j, 3:4)];
    end
    
    % decimate image to three scales
    for i = 1 : 2
        %dog = DoG(I, baseSigma);
        I = decimate(I, 2);
        boxSize = boxSize / 2;
        
        % H_detect returns set of [x y theta]
        % append the size we found the point at
        smallerPointsList = H_detectFeatures(I, .005, thresh, 'p');
        smallerPointsList(:,4) = boxSize;
        
        % add all points to our interest points list
        % when we decimate an image, we remove every other row and column,
        % so when we detect features on a decimated image, we know that we
        % are taking 2*decimation steps instead of one
        for j = 1 : size(smallerPointsList, 1)
            x = min(smallerPointsList(j, 1) * (2^i), maxX); 
            y = min(smallerPointsList(j, 2) * (2^i), maxY);
            
            % flag interest point at image location if not already flaged
            if (interestPointsMatrix(y, x, 1) == 0)
                
                % add to matrix
                interestPointsMatrix(y, x, :) = [1 smallerPointsList(3:4)];
            end
        end
    end
    
    % using difference of gaussians, filter out points that arent scale
    % invarient
    
    dog = DoG(O, baseSigma); % umm cry because you dont know what to do with this
            
    for i = 2 : size(dog, 3)
        dog(:,:,1) = dog(:,:,1) .* dog(:,:,i); 
    end
     
    interestPointsMatrix(:,:,1) = interestPointsMatrix(:,:,1) .* dog(:,:,1);
%     imshow([interestPointsMatrix(:,:,1) dog(:,:,1)]);
     
    interestPoints = [0 0 0 0];
     
    for y = 1 : size(interestPointsMatrix, 1)
        for x = 1 : size(interestPointsMatrix, 2)
             if (interestPointsMatrix(y, x, 1) ~= 0)
                 interestPoints = [interestPoints ; x y interestPointsMatrix(y, x, 2) interestPointsMatrix(y, x, 3)];
             end
         end
     end
     
     interestPoints = interestPoints(2:end, :);
end