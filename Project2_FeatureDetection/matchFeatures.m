function [matches] = matchFeatures(I1, I2, maxDistance, CT, baseSigma, threshold, sliceSize)
    % given two untampered images I1, I2
    % this function returns an arraylist consisting of feature pairs
    % maxDistance - the allowable amount of difference two features may
    % have to be considered matching
    % CT - Corner threshold, how far away does it have to be from
    % the corners because, normally, features close to the outter corners
    % are bad.
    
    % the 20 here is arbitrary, we dont actually care about drawing
    % these features 
    f1 = harrisDetection(I1, baseSigma, 20, threshold);
    f2 = harrisDetection(I2, baseSigma, 20, threshold);
    
    
    % filter out corners of image%%%%%%%%%%%%%%%%%%%%%%%%%%
    % there is probably a better way to do this.
    indices = find(f1(:,1) < CT);
    f1(indices,:) = [];
    indices = find(f1(:,2) < CT);
    f1(indices,:) = [];
    
    indices = find(f2(:,1) < CT);
    f2(indices,:) = [];
    indices = find(f2(:,2) < CT);
    f2(indices,:) = [];
    
    maxX = size(I1, 1) - CT;
    maxY = size(I1, 2) - CT;
    
    indices = find(f1(:,1) > maxX);
    f1(indices,:) = [];
    indices = find(f1(:,2) > maxY);
    f1(indices,:) = [];
    
    maxX = size(I2, 1) - CT;
    maxY = size(I2, 2) - CT;
    
    indices = find(f2(:,1) > maxX);
    f2(indices,:) = [];
    indices = find(f2(:,2) > maxY);
    f2(indices,:) = [];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    v1 = convertToVectors(I1, f1, sliceSize);
    v2 = convertToVectors(I2, f2, sliceSize);
    
    matches = java.util.ArrayList();
    
    
    % for every v1,
    % get its min SSD from v2
    % if the minSSD is allowable, 
    % match them
    for i = 0 : v1.size() - 1
        minSSD = intmax;
        prevMinSSD = intmax;
        minMatch = [];
        vec1 = v1.get(i);
        if (v2.size() > 0) % wouldnt make sense to run with no values
            for j = 0 : v2.size() - 1
                newSSD = SSD(vec1, v2.get(j));
                if minSSD > newSSD
                    % pair them
                    prevMinSSD = minSSD;
                    minSSD = newSSD;
                    minMatch = [f1(i+1,:) ; f2(j + 1,:)];
                end
            end
            
            % now that we have the minSSD
            % if it is within our allowable distance
            % make the match
            if isempty(minMatch) == false && (minSSD / prevMinSSD) < maxDistance
                matches.add(minMatch);
                %v2.remove(minMatchID);
            end
        end
    end
end