function [averagePrecision, MAP, accuracy] = evaluation(categories, vocSize, testSize,  fExtraction, denseSampling, centers, SVMs)
% Evaluates a the test set on the SVMs provided.
% Returns average precision, mean average precision, prediction accuracy.

testData = getData(categories, 'test', testSize');
testDataList = getSubsetFromData(testData, ':');

histogramsEval = [];
classLabelsEval = [];
PredictedEstimates = [];


averagePrecision = [];

c = 0;
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

[ averagePrecision, MAP, accuracy] = evaluate(categories, classLabelsEval, histogramsEval, SVMs);

