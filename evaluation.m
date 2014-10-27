categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
testData = getData(categories, 'test', 'max');
histogramsEval = [];
classLabelsEval = [];
PredictedEstimates = [];
c = 0;
fExtraction = 'opponentSift';
denseSampling = true;
vocSize = 400;
trainingSize = 'max';
visualVocBuildingSize = 250;
folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));
skipExisting = true;
averagePrecision = [];
if(isdir(folderPath) && skipExisting)
    warning('We opted for skipping this visual description set as the folder already exists');
    load(strcat(folderPath,'/SVMs'),'SVMs');
    load(strcat(folderPath,'/eval/histogramsEval'),'histogramsEval');
    load(strcat(folderPath,'/eval/classLabelsEval'),'classLabelsEval');
else
    disp('Get visual descriptions');
    % Build the visual vocabulary for the test data
    for category = categories
        disp(char(category));
        images = getfield(testData, char(category));
        visualDescriptions = getVisualDescriptions(images, centers, fExtraction, denseSampling);
        classLabelsEval = [ classLabelsEval ; repmat( c, [size(visualDescriptions,1), 1] )];
        histogramsEval = [ histogramsEval ; visualDescriptions ];  
        c = c + 1;
    end
    % to save them:
    [s, mess, messid] = mkdir(folderPath);
    save(strcat(folderPath,'/histogramsEval'),'histogramsEval');
    save(strcat(folderPath,'/classLabelsEval'),'classLabelsEval');
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
    averagePrecision = [averagePrecision 1/sum(ranking(:,3))*sum(ranking(:,3).*cumsum(ranking(:,3))./(1:size(ranking,1))')];

    % Put the probability estimation in a matrix
    PredictedEstimates = [PredictedEstimates probEstimates(:,1)];
    
    c = c + 1;
end

% Mean Average Precision for all classes
MAP = mean(averagePrecision);
% Calculate the class indices for the predictions giving the class with the maximum
% probability
[values,predictedClassLabels] = max(PredictedEstimates,[],2);
% Shift the class indices by one
predictedClassLabels = (predictedClassLabels-1);
% Get the accuracy of the predictions
accuracy = mean( predictedClassLabels == classLabelsEval );
% Print the result
disp('Average Precision per class: ');
disp(averagePrecision);
disp('Mean Average Precision: ');
disp(MAP);
disp('Prediction Accuracy: ');
disp(accuracy);
