function [descriptors ] = grayscaleSift( input, denseSampling )
    % f: keypoints, d: descriptor
    if(ndims(input) < 3)
        input = rgb2gray(input);
    end
    
    if(denseSampling)
        [~ ,descriptors] = vl_dsift(single((input)));
    else
        [~ ,descriptors] = vl_sift(single((input)));
    end
end