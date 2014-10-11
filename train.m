categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
SVMs = struct();
classLabels = [];
histograms = [];

dataSet = getData(categories, 'train', 60);
vocSize = 400;
visualVocabImagePaths = getSubsetFromData(dataSet, 1:20);
disp('Build visual vocabulary');
centers = buildVisualVoc(visualVocabImagePaths, vocSize);

disp('Get visual descriptions');
c = 0;
for category = categories
    disp(char(category));
    images = getfield(dataSet, char(category));
    visualDescriptions = getVisualDescriptions(images(21:60,:), centers);
    classLabels = [ classLabels ; repmat( c, [size(visualDescriptions,1), 1] )];
    histograms = [ histograms ; visualDescriptions ];  
    c = c + 1;
end
disp('Train SVMs');
c = 0;
for category = categories
    disp(char(category));
    svm = svmtrain(double(classLabels == c), histograms);
    SVMs = setfield(SVMs, char(category), svm);
    c = c + 1;
end