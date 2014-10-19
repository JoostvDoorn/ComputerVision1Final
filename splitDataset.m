function [ filePaths1, dataset2 ] = splitDataset( dataset, size1 )
% splits data sets into two subsets where subset 1 has size size1.
% subset1 is a vector of paths
% subset 2 retains the category structure

    names = fieldnames(dataset);
    
    sizes = [];
    
    for f = names'
        images = getfield(dataset, char(f));
        sizes = [sizes; size(images,1)];
    end    
    maxSize = min(sizes);
    
    if size1 >= maxSize
       error('splitDataset: subset size given is greater or equal to the data set');
    end
    
    sub1Selectors = randsample(maxSize, size1);
    
    filePaths1 = getSubsetFromData(dataset, sub1Selectors);
    
    dataset2 = struct();
    
    for f = names';
         files = getfield(dataset, char(f));
         sub2Selectors = setdiff(1:size(files,1), sub1Selectors);
         dataset2 = setfield(dataset2, char(f), files(sub2Selectors,:));     
    end
        
end