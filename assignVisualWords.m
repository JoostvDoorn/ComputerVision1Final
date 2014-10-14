function [visualWords, h] = assignVisualWords(descriptors, centers )
    % descriptors:  m x n matrix of n keypoints and m descriptors
    % centers:      m x k matrix containing the centroids for each class k for
    %               the coordinates m
    %
    % h:            a 1 x k vector containing the normalized counts for each
    %               visual word
    % visualWords:  a 1 x n vector containing the assigned visual
    %               word for each keypoint
    
    visualWords = zeros(1, size(descriptors,2));
    for i=1:size(descriptors,2)

        [~, k] = min(vl_alldist(single(descriptors(:,i)), centers)) ;
        visualWords(1,i) = k;
    end

    % create histogram, normalized so that max is 1
    %h = hist(visualWords, size(centers,2)) ./ size(descriptors,2);
    h = hist(visualWords, size(centers,2));
    h = h ./ max(h);
         
end

