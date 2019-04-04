function [P] = makePanorama(D)
    % the purpose of this function is to read in a dir of files
    % with the extension .JPG. All of the files need to be numbered 1-10
    % I use hugheylab-nestedSortStruct to ensure the images are ordered
    % correctly. If you are having a hard time getting it to run, tweak 
    % the parameters allowed_maping_error, trials, in align.m or make the
    % panorama manually. 
    
    
    % D = 'directory where the files are saved';
    S = dir(fullfile(D,'*.JPG')); % pattern to match filenames.
    S = nestedSortStruct(S, 'name');
    
    F = fullfile(D,S(1).name);
    I = imread(F);
    
    if (size(I,2) > 150 || size(I,1) > 1000)
        I = imresize(I, .16); % scale down
    end
    
    W = I;
    
    for k = 2:numel(S)
        F = fullfile(D,S(k).name);
        I = imread(F);
        if (size(I,2) > 1000 || size(I,1) > 1000)
            I = imresize(I, .16); % scale down
        end
        
        W = align(W, I, 'a');
    end
    P = W;
end