function [ filePaths ] = getSubsetFromData( dataSet, selector )
    %Returns a list of filepaths that represents a subset of the
    %dataset
    % dataSet:      The struct with the filepaths
    % selector:     A selector to get the subset
    % Returns:
    % filePaths:    Array with the filepaths selected using the selector
    % for each class concatenated into one array
    names = fieldnames(dataSet);
    filePaths = [];
    for f = names'
        images = getfield(dataSet, char(f));
        wo = size(filePaths, 2);
        wn = size(images, 2);
        selection = images(selector, :);
        fillOld = repmat( ' ', [ size(filePaths, 1), max(wn-wo,0)] );
        fillNew = repmat( ' ', [ size(selection, 1), max(wo-wn,0)] );
        filePaths = [ filePaths fillOld; selection fillNew ];
    end
end

