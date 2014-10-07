function [ output_args ] = feature_extraction( target )
    % f: keypoints, d: descriptor
    [f, d] = vl_sift(single(rgb2gray(target)));
    hold on;
    imshow(test);
    plot(f(1), f(2), 'r*');
    hold off;
end

