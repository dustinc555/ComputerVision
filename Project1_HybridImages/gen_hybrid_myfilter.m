function [H] = gen_hybrid_myfilter(highFreqImg, lowFreqImg)
    s1 = size(highFreqImg);
    s2 = size(lowFreqImg);
    minRow = min(s1(1), s2(1));
    minCol = min(s2(2), s2(2));
    
    cutoff_freq = 7;
        
    highFreqImg = imresize(highFreqImg, [minRow, minCol]);
    lowFreqImg = imresize(lowFreqImg, [minRow, minCol]);
    
    filter = fspecial('Gaussian', cutoff_freq*4+1, cutoff_freq);
    highFreq = highFreqImg - my_imfilter(highFreqImg, filter);
    lowFreq = my_imfilter(lowFreqImg, filter);

    H = highFreq + lowFreq;
end