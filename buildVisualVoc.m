function [C, A] = buildVisualVoc(descriptors, vocSize )
    % descriptors: m x n matrix with n keypoints and m descriptors
    % vocSize: vocabulary size for visual vocabulary
    % returns: C, m x vocSize matrix contianing the centroids
    [C, A] = vl_kmeans(single(descriptors), vocSize);
end