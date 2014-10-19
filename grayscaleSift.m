function [descriptors ] = grayscaleSift( input )
    % f: keypoints, d: descriptor

    [~ ,descriptors] = vl_sift(single(rgb2gray(input)));

end