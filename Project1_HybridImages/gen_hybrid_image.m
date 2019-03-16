function [H] = gen_hybrid_image(highFreqImg, lowFreqImg, method)
    switch method
        case "FFT"
            H = gen_hybrid_FFT(highFreqImg, lowFreqImg);
        case "my_filter"
            H = gen_hybrid_myfilter(highFreqImg, lowFreqImg);
    end
end