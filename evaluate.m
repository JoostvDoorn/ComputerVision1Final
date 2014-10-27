function [ averagePrecision] = evaluate(categories, classLabelsEval, histogramsEval, SVMs)


PredictedEstimates = [];
averagePrecision = [];


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

end