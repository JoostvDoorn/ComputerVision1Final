function [ keypoints, descriptors ] = featureExtraction( input )
    % f: keypoints, d: descriptor
    if(ndims(input) < 3)
        temp = input;
       input(:,:,1) = temp;
       input(:,:,2) = temp;
       input(:,:,3) = temp;
    end
    [keypoints, descriptors] = vl_sift(single(rgb2gray(input)));
    [x, dR] = vl_sift(single(input(:,:,1)), 'frames', keypoints);
    [x, dG] = vl_sift(single(input(:,:,2)), 'frames', keypoints);
    [x, dB] = vl_sift(single(input(:,:,3)), 'frames', keypoints);

    %imshow(single(input(:,:,1)),[]);
    %hold on;
    %plot(keypoints(1,:), keypoints(2,:), 'r*');
    %hold off;
    %descriptors = [ dR; dG; dB ];
end
