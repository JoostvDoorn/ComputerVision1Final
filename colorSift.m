function [descriptors ] = colorSift( inputImage, originalImage, denseSampling )
    % fE: feature extraction options
    % f: keypoints, d: descriptor
    if(ndims(inputImage) < 3)
        temp = inputImage;
        inputImage(:,:,1) = temp;
        inputImage(:,:,2) = temp;
        inputImage(:,:,3) = temp;
    end
    
    if(denseSampling)
        stepSize = 32; % The step size of dense sift
        [x, dR] = vl_dsift(single(inputImage(:,:,1)), 'step', stepSize);
        [x, dG] = vl_dsift(single(inputImage(:,:,2)), 'step', stepSize);
        [x, dB] = vl_dsift(single(inputImage(:,:,3)), 'step', stepSize);
    else
        if(ndims(originalImage) == 3)
            originalImage = rgb2gray(originalImage);
        end
        [keypoints, ~] = vl_sift(single(originalImage));
        [x, dR] = vl_sift(single(inputImage(:,:,1)), 'frames', keypoints);
        [x, dG] = vl_sift(single(inputImage(:,:,2)), 'frames', keypoints);
        [x, dB] = vl_sift(single(inputImage(:,:,3)), 'frames', keypoints);
    end

    descriptors = [ dR; dG; dB ];
end