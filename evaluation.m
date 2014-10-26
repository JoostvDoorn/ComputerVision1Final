categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
testData = getData(categories, 'test', 4);
histogramsEval = [];
classLabelsEval = [];
PredictedEstimates = [];
c = 0;
fExtraction = 'grayscaleSift';
denseSampling = false;
vocSize = 400;
trainingSize = 'max';
visualVocBuildingSize = 250;
folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling),'/eval/);
skipExisting = true;
if(isdir(folderPath) && skipExisting)
    warning('We opted for skipping this visual description set as the folder already exists');
    load(strcat(folderPath,'/histogramsEval'),'histogramsEval');
    load(strcat(folderPath,'/classLabelsEval'),'classLabelsEval');
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
predictedRanking = [];
rankingScore = [];
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
    [Predicted, accuracy, probEstimates] = svmpredict(labelsEval, histogramsEval, svm);
    % Put the probability estimation in a matrix
    PredictedEstimates = [PredictedEstimates probEstimates];
    % Get the ranking
    ranking = sort([probEstimates double(Predicted == 1) double(labelsEval == 1)], 'descend');
    % Calculate mean average precision
    meanAveragePrecision = 1/sum(ranking(:,3))*sum(ranking(:,3).*cumsum(ranking(:,2))./(1:size(ranking,1))');
    rankingScore = [ rankingScore meanAveragePrecision ];
    predictedRanking = [ predictedRanking ranking(:,1) ];
    %PredictedEstimatesStruct = setfield(PredictedEstimates, char(category), Predicted);
    c = c + 1;
end
% Calculate the class indices for the predictions giving the class with the maximum
% probability
[values,predictedClassLabelsPrime] = max(PredictedEstimates');
% Shift the class indices by one
predictedClassLabels = (predictedClassLabelsPrime'-1);
% Get the accuracy of the predictions
accuracy = mean( predictedClassLabels == classLabelsEval );
% Print the result
disp('Combined accuracy: ');
disp(accuracy);
disp(rankingScore);
