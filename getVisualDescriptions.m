function [histograms] = getVisualDescriptions(imageFiles, centers)
    % imageFiles:   L x 1 vector containing paths to images
    % c:            centers of visual vocabulary (m x k matrix, with m descriptor
    %               features
    % h:            normalized histogram

    histograms = [];
    
    for i=1:size(imageFiles,1)
        im = imread(imageFiles(i,:));
        [~, d] = featureExtraction(im);
        [~, h] = assignVisualWords(d, centers ); 
        histograms = [histograms; h];
    end


end
