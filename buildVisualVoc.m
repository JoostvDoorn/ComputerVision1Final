function [C] = buildVisualVoc(imageFiles, vocSize, fE, denseSampling)
    % imageFiles:  L x 1 matrix with L file paths for image files
    % vocSize:      vocabulary size for visual vocabulary
    % C:            m x vocSize matrix contianing the centroids
    % fE:           feature extraction options
    
    descriptors = [];
    
    % for each image, get the descriptors and concatenate them.
    for i=1:size(imageFiles,1)
        im = imread(imageFiles(i,:));
        imDesc = featureExtraction(im, fE, denseSampling);
        descriptors = [descriptors imDesc];
    end
    
    % calculate k-means over the descriptors of all images
    [C, A] = vl_kmeans(single(descriptors), vocSize);

end