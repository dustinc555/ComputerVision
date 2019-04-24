function [Um, X] = computeUnbiasedMatrix(Images)
    X = vectorizeImages(Images);
        
    Favg = computeFavg(X);
        
    Um = combine(X, Favg);
    
    X = cell2mat(X);
end