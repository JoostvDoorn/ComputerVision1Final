function [C] = buildVisualVoc(imageFiles, vocSize, fE, denseSampling)
    % Builds the visual vocabulary
    % imageFiles:    L x 1 matrix with L file paths for image files
    % vocSize:       vocabulary size for visual vocabulary
    % fE:            feature extraction options
    % denseSampling: dense sampling options
    % Returns
    % C:             m x vocSize matrix containing the centroids
    
    descriptors = [];
    
    % for each image, get the descriptors and concatenate them.
    for i=1:size(imageFiles,1)
        % Read the image from the file
        im = imread(imageFiles(i,:));
        % Extract the image descriptors
        imDesc = featureExtraction(im, fE, denseSampling);
        % Append descriptors
        descriptors = [descriptors imDesc];
    end
    
    % calculate k-means over the descriptors of all images
    [C, A] = vl_kmeans(single(descriptors), vocSize);

end