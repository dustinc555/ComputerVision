function [A] = computeFavg(Images)
    if (length(Images) <= 0)
       A = 0;
       return; 
    end
    
    
    A = Images{1};
    for i = 2 : length(Images)
        A = A + Images{i};
    end
    
    A = A ./ length(Images);
end