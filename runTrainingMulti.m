% This script trains the SVMs
vocSizes = [ 400, 800, 1600, 2000, 4000 ];
extractions = { 'colorSift' };
for extraction=extractions,
    for voc=vocSizes,
       categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
        vocSize = voc;
        trainingSize = 'max';
        visualVocBuildingSize = 250;
        svmOptions = '-t 0 -w1 3 -b 1';
        fExtraction = char(extraction);
        denseSampling = true;
        folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));
        skipExisting = true;
        saveHistograms = true;
        saveLabels = saveHistograms;
        if(isdir(folderPath) && skipExisting)
            warning('We opted for skipping this training as the folder already exists');
            load(strcat(folderPath,'/SVMs'),'SVMs');
            load(strcat(folderPath,'/centers'),'centers');
            load(strcat(folderPath,'/classLabels'),'classLabels');
            load(strcat(folderPath,'/histograms'),'histograms');
        else
            [centers, histograms, classLabels] = train(categories, vocSize, trainingSize, visualVocBuildingSize, fExtraction, denseSampling);
            % to save them:
            [s, mess, messid] = mkdir(folderPath);
            save(strcat(folderPath,'/centers'),'centers');
            if(saveLabels)
                save(strcat(folderPath,'/classLabels'),'classLabels');
            end
            if(saveHistograms)
                save(strcat(folderPath,'/histograms'),'histograms');
            end
            [SVMs] = trainsvm(histograms, classLabels, categories, svmOptions);
            % to save them:
            save(strcat(folderPath,'/SVMs'),'SVMs');
        end
    end
end
