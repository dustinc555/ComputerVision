function [Images] = vectorizeImages(Images)
    for i = 1 : length(Images)  % vectorize images
       Images{i} = Images{i}(:); 
    end
end