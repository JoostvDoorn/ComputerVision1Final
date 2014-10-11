function [visualWords] = assignVisualWords(descriptors, centers )
    % descriptors: m x n matrix of n keypoints and m descriptors
    % centers: m x k matrix containing the centroids for each class k for
    % the coordinates m
    % returns visualWords: a 1 x n vector containing the assigned visual
    % word for each keypoint
    visualWords = zeros(1, size(descriptors,2));
    for i=1:size(descriptors,2)

        [~, k] = min(vl_alldist(single(descriptors(:,i)), centers)) ;
        visualWords(1,i) = k;
    end


end