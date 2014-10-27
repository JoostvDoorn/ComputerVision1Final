function [histograms] = getVisualDescriptions(imageFiles, centers, fE, denseSampling)
    % imageFiles:    L x 1 vector containing paths to images
    % centers:       centers of visual vocabulary (m x k matrix, with m descriptor
    %                features
    % fE:            feature extraction options
    % denseSampling: argument to indicate whether or not dense sampeling is
    %                used
    % histograms:    normalized histogram

    histograms = [];
    
    for i=1:size(imageFiles,1)
        im = imread(imageFiles(i,:));
        d = featureExtraction(im, fE, denseSampling);
        [~, h] = assignVisualWords(d, centers ); 
        histograms = [histograms; h];
    end


end
