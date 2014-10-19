function [descriptors ] = colorSift( input, denseSampling )
    % fE: feature extraction options
    % f: keypoints, d: descriptor
    if(ndims(input) < 3)
        temp = input;
        input(:,:,1) = temp;
        input(:,:,2) = temp;
        input(:,:,3) = temp;
    end
    
    if(denseSampling)
        [x, dR] = vl_dsift(single(input(:,:,1)));
        [x, dG] = vl_dsift(single(input(:,:,2)));
        [x, dB] = vl_dsift(single(input(:,:,3)));
    else
        [keypoints, ~] = vl_sift(single(rgb2gray(input)));
        [x, dR] = vl_sift(single(input(:,:,1)), 'frames', keypoints);
        [x, dG] = vl_sift(single(input(:,:,2)), 'frames', keypoints);
        [x, dB] = vl_sift(single(input(:,:,3)), 'frames', keypoints);
    end

    descriptors = [ dR; dG; dB ];
end