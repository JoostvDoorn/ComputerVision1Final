% This script trains the SVMs

categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
vocSize = 30;
trainingSize = 30;
visualVocBuildingSize = 10;
svmOptions = '-t 0';
fExtraction = 'grayscaleSift';

[SVMs, centers] = train(categories, vocSize, trainingSize, visualVocBuildingSize, svmOptions, fExtraction);

% to save them:
% save filenameSVMs SVMs
% save filenameCenters centers