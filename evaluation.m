categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
testData = getData(categories, 'test', 4);
histogramsEval = [];
classLabelsEval = [];
PredictedEstimates = [];

disp('Get visual descriptions');
c = 0;
% Build the visual vocabulary for the test data
for category = categories
    disp(char(category));
    images = getfield(testData, char(category));
    visualDescriptions = getVisualDescriptions(images, centers);
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
    [Predicted, accuracy, probEstimates] = svmpredict(labelsEval, histogramsEval, svm);
    % Put the probability estimation in a matrix
    PredictedEstimates = [PredictedEstimates probEstimates];
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