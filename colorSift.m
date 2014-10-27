function [descriptors ] = colorSift( inputImage, originalImage, denseSampling )
    % Applies color sift on the input image
    % inputImage: the input image used for feature extraction
    % originalImage: the original image used for keypoints
    % denseSampling: dense sampling option
    % Returns:
    % descriptors: The descriptors of the image
    
    % Replicate grayscale images over all channels
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
        % Get the keypoints on the grayscale image and applies sift on the
        % color channel afterwards
        if(ndims(originalImage) == 3)
            originalImage = rgb2gray(originalImage);
        end
        % Apply sift on each of the channels
        [keypoints, ~] = vl_sift(single(originalImage));
        [~, dR] = vl_sift(single(inputImage(:,:,1)), 'frames', keypoints);
        [~, dG] = vl_sift(single(inputImage(:,:,2)), 'frames', keypoints);
        [~, dB] = vl_sift(single(inputImage(:,:,3)), 'frames', keypoints);
    end
    % The returned descriptors
    descriptors = [ dR; dG; dB ];
end