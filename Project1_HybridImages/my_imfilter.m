function output = my_imfilter(image, filter)
    if (mod(filter(1), 2) == 0 && mod(filter(2), 2) == 0)
        error("Warning, even dimention filter");
    end
    
    % ensure correct padding
    function one_channel_output = one_channel_filter(image, filter)    
        img_height = size(image, 1);
        img_width = size(image, 2);
        filter_height = size(filter, 1);
        filter_width = size(filter, 2);
        pad_height = (filter_height - 1)/2;
        pad_width = (filter_width - 1)/2;

        one_channel_output = zeros(img_height, img_width, 'uint8');
        padded = zeros(img_height + 2 * pad_height, img_width + 2 * pad_width); 
        padded(1 + pad_height: img_height + pad_height, 1 + pad_width: img_width + pad_width) = image; 
        for ii = 1 : img_height
            for jj = 1 : img_width
                submatrix = padded(ii : ii + 2 * pad_height, jj : jj + 2 * pad_width);     
                one_channel_output(ii, jj) = sum(sum(submatrix .* filter));
            end
        end
    end

    % check if grayscale
    output = zeros(size(image), 'uint8');
    dim = length(size(image)); 
    if (dim == 1)
        output = one_channel_filter(image, filter);
    elseif (dim == 3)
        for d = 1: 3
            output(:, :, d) = one_channel_filter(image(:, :, d), filter);
        end
    end
end