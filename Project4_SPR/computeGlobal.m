function [L, G, globalX, globalK, LOrig, GOrig, optimalKSet] = computeGlobal()
    names = getTrainingSetNames();
    optimalKSet = [];
    L = [];
    G = [];
    globalX = [];
    globalK = [];
    
    for i = 1 : size(names, 2)
        dr = char('TrainingImages\' + names(i) + '\UnProcessed');
        
        % 1. Concatenate each of the kn-dimensional eigenspaces into a matrix L and compute the
        % eigenspace of L.
        % 2. Concatenate all 2B images for each of the n objects into a matrix G and compute the
        % eigenspace of this G.

        % get X and Xhat from directory
        images = loadDirectory('a', dr);
        
        [Xhat, X] = computeUnbiasedMatrix(images);
        
        [U, S, V] = svd(Xhat, 0); % economy svd
        
        % get optimalK
        [optimalK, K] = ComputeER(X, U, S, .90);
  
        L = [L, U(:, 1:optimalK)];
        G = [G, Xhat];
        
        globalX = [globalX, X];
        
        globalK = [globalK, K];
        
        optimalKSet = [optimalKSet, optimalK];
    end
    
    LOrig = L;
    GOrig = G;
    
    [U, S, V] = svd(L, 0);
    L = U;
    
    [U, S, V] = svd(L, 0);
    G = U;
    
end