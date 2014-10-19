% This script trains the SVMs

categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
vocSize = 400;
trainingSize = 30;
visualVocBuildingSize = 10;
svmOptions = '-t 0';
fExtraction = 'grayscaleSift';
denseSampling = false;
folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));
skipExisting = true;
if(isdir(folderPath) && skipExisting)
    warning('We opted for skipping this training as the folder already exists');
    load(strcat(folderPath,'/SVMs'),'SVMs');
    load(strcat(folderPath,'/centers'),'centers');
else
    [SVMs, centers] = train(categories, vocSize, trainingSize, visualVocBuildingSize, svmOptions, fExtraction, denseSampling);
    % to save them:
    [s, mess, messid] = mkdir(folderPath);
    save(strcat(folderPath,'/SVMs'),'SVMs');
    save(strcat(folderPath,'/centers'),'centers');
end