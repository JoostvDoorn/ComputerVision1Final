% demoRun for specific parameters
% This script will run an entire training and evaluation cycle.

% set parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
vocSize = 400;
trainingSize = 40;
visualVocBuildingSize = 10;
svmOptions = '-t 0 -w1 3 -b 1';
fExtraction = 'grayscaleSift';
denseSampling = false;

testSize = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% training phase
[centers, histograms, classLabels] = train(categories, vocSize, trainingSize, visualVocBuildingSize, fExtraction, denseSampling);
[SVMs] = trainsvm(histograms, classLabels, categories, svmOptions);

% evaluation phase
[averagePrecision, MAP, accuracy, predictedClassLabels] = evaluation(categories, vocSize, testSize,  fExtraction, denseSampling, centers, SVMs);


% Print the result
disp('Average Precision per class: ');
disp(averagePrecision);
disp('Mean Average Precision: ');
disp(MAP);
disp('Prediction Accuracy: ');
disp(accuracy);