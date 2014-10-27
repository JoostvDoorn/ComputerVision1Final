function [centers, histograms, classLabels] = train(categories, vocSize, samplesSize, vocSamples, fE, denseSampling)
    % Returns centers, histograms and class labels for specfic training
    % parameters.
    
    classLabels = [];
    histograms = [];
    % Get time at start
    startTime = cputime;
    dataSet = getData(categories, 'train', samplesSize);
    %vocSize = 400;
    [visualVocabImagePaths, trainImages] = splitDataset(dataSet, vocSamples);
    disp('Build visual vocabulary');
    centers = buildVisualVoc(visualVocabImagePaths, vocSize, fE, denseSampling);

    disp('Get visual descriptions');
    c = 0;
    for category = categories
        disp(char(category));
        images = getfield(trainImages, char(category));
        visualDescriptions = getVisualDescriptions(images, centers, fE, denseSampling);
        classLabels = [ classLabels ; repmat( c, [size(visualDescriptions,1), 1] )];
        histograms = [ histograms ; visualDescriptions ];  
        c = c + 1;
    end
    % Elapsed time
    endTime = cputime-startTime
end
