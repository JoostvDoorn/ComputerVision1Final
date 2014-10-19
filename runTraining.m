% This script trains the SVMs

categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
vocSize = 30;
trainingSize = 30;
visualVocBuildingSize = 10;
svmOptions = '-t 0';
fExtraction = 'grayscaleSift';
denseSampling = false;
folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'dense',num2str(denseSampling));
skipExisting = true;
if(isdir(folderPath) && skipExisting)
     warning('We opted for skipping this training as the folder already exists');
else
    [SVMs, centers] = train(categories, vocSize, trainingSize, visualVocBuildingSize, svmOptions, fExtraction, denseSampling);
end
% to save them:
[s, mess, messid] = mkdir(folderPath);
save(strcat(folderPath,'/SVMs'),'SVMs');
save(strcat(folderPath,'/centers'),'centers');