function [h] = getVisualDesription(im, centers)
% im:   image matrix
% c:    centers of visual vocabulary (m x k matrix, with m descriptor
%       features
% h:    normalized histogram
[k, d] = feature_extraction(im);
[visualWords, h] = assignVisualWords(d, centers );
end