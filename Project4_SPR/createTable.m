function [T] = createTable()
    [L, G, globalX, globalK] = computeGlobal();
    
    properties = cellstr(getTrainingSetNames());
        
    T = array2table(globalK, 'VariableNames', properties);
end