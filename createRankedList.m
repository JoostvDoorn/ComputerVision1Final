function [] = createRankedList(categories, vocSize, testSize,  fExtraction, denseSampling, centers, SVMs)
% Creates a ranked list in the directory specified below.
% Note that existing files will be overwritten each time.

% output path
rankedPath = strcat('results/ranked');

testData = getData(categories, 'test', testSize');
testDataList = getSubsetFromData(testData, ':');

histogramsEval = [];
classLabelsEval = [];
PredictedEstimates = [];



rankedPath = strcat('results/ranked');
% Make folder for the ranked lists
[~,~,~] = mkdir(rankedPath);

averagePrecision = [];

disp('Get visual descriptions');
% Build the visual vocabulary for the test data
c = 0;
for category = categories
    disp(char(category));
    images = getfield(testData, char(category));
    visualDescriptions = getVisualDescriptions(images, centers, fExtraction, denseSampling);
    classLabelsEval = [ classLabelsEval ; repmat( c, [size(visualDescriptions,1), 1] )];
    histogramsEval = [ histogramsEval ; visualDescriptions ];  
    c = c + 1;
end



c = 0;
for category = categories
    disp(char(category));
    % Get the SVM
    svm = getfield(SVMs, char(category));
    % Set the labels to one and minus one
    labelsEval = ones(size(classLabelsEval));
    labelsEval(classLabelsEval ~= c) = -1;
    % Use the SVM to classify each of the images and get the probability
    % estimation
    [Predicted, ~, probEstimates] = svmpredict(labelsEval, histogramsEval, svm, '-b 1');
    predictionMatrix = [probEstimates double(labelsEval == 1)];
    % Sort the probabilities of the data belonging to the current class in
    % descending order
    [Y,I]=sort(predictionMatrix(:,1), 'descend');
    ranking = predictionMatrix(I,:);
    % Get the ranked list for the current object class
    rankedList = testDataList(I,:);
    % Save the list to a file
    fileID = fopen(char(strcat(rankedPath, '/', categories(c+1),'.txt')),'w');
    for i=1:size(rankedList,1)
        fprintf(fileID,'%s\n', rankedList(i,:));
    end
    fclose(fileID);
    
    c = c + 1;
end

