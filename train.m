dataSet = getData('train', 30);
vocSize = 400;
visualVocabImagePaths = getSubsetFromData(dataSet, 1:3);
disp('Build visual vocabulary');
centers = buildVisualVoc(visualVocabImagePaths, vocSize);

disp('Get visual descriptions');
categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
for category = categories
    disp(char(category));
    images = getfield(dataSet, char(category));
    histograms = getVisualDescriptions(images(4:30,:), centers);
end