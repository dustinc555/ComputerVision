
function [H] = gen_hybrid_FFT(highFreqImg, lowFreqImg)
    sigmaHigh = 7;
    sigmaLow = 7;
    s1 = size(highFreqImg);
    s2 = size(lowFreqImg);
    minRow = min(s1(1), s2(1));
    minCol = min(s2(2), s2(2));
        
    highFreqImg = imresize(highFreqImg, [minRow, minCol]);
    lowFreqImg = imresize(lowFreqImg, [minRow, minCol]);

    highFreqImg = fft2(highFreqImg);
    lowFreqImg = fft2(lowFreqImg);
    highFreqImg = fftshift(highFreqImg);
    lowFreqImg = fftshift(lowFreqImg);
    
    highFilter = my_gaussfilter(highFreqImg, sigmaHigh, true);
    lowFilter = my_gaussfilter(lowFreqImg, sigmaLow, false);
    
    FFT_COMBINED = (highFreqImg .* highFilter) + (lowFreqImg .* lowFilter);
    
    H = uint8( ifft2( ifftshift( FFT_COMBINED ) ) );
end