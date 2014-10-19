function [descriptors ] = grayscaleSift( input )
    % f: keypoints, d: descriptor
    
    
    if(ndims(input) < 3)
        [~ ,descriptors] = vl_sift(single((input)));
    
    else
        
        [~ ,descriptors] = vl_sift(single(rgb2gray(input)));
            
    end

end