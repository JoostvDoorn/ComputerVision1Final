% demoRun for specific parameters
% This script will run an entire training and evaluation cycle.

% set parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
vocSize = 400;
trainingSize = 'max';
visualVocBuildingSize = 10;
svmOptions = '-t 0 -w1 3 -b 1';
fExtraction = 'grayscaleSift';
denseSampling = false;

testSize = 'max'; % number of test samples per class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% training phase
[centers, histograms, classLabels] = train(categories, vocSize, trainingSize, visualVocBuildingSize, fExtraction, denseSampling);
[SVMs] = trainsvm(histograms, classLabels, categories, svmOptions);

%createRankedList(categories, vocSize, testSize,  fExtraction, denseSampling, centers, SVMs);

% evaluation phase
[averagePrecision, MAP, accuracy] = evaluation(categories, vocSize, testSize,  fExtraction, denseSampling, centers, SVMs);

% The following line outputs a ranked list for each class in
% results/ranked/ ...
%createRankedList(categories, vocSize, testSize,  fExtraction, denseSampling, centers, SVMs);


% Print the result
disp('Average Precision per class: ');
disp(averagePrecision);
disp('Mean Average Precision: ');
disp(MAP);
disp('Prediction Accuracy: ');
disp(accuracy);