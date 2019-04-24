function [I] = loadDirectory(mode, path)
    if (mode == 'm')
        dr = uigetdir();
    elseif (mode == 'a')
        dr = path;
    end
    
    list = dir([char(dr), '\*.png']);
    I = {length(list)};
    
    for x = 1 : length(list)
         I{x}=imread([dr, '\', list(x).name]);
    end
end