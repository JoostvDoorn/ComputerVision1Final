categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
testData = getData(categories, 'test', 4);
histogramsEval = [];
classLabelsEval = [];
PredictedLabels = struct();

disp('Get visual descriptions');
c = 0;
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
    svm = getfield(SVMs, char(category));
    Predicted = svmpredict(double(classLabelsEval == c), histogramsEval, svm);
    PredictedLabels = setfield(PredictedLabels, char(category), Predicted);
    c = c + 1;
end