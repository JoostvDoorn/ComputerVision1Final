% This script trains the SVMs
vocSizes = [ 400, 800, 1600, 2000, 4000 ];
extractions = { 'colorSift' };
for extraction=extractions,
    for voc=vocSizes,
       categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
        vocSize = voc;
        trainingSize = 'max';
        visualVocBuildingSize = 250;
        kernel = 0;
        svmOptions = strcat('-t ',kernel,' -w1 3 -b 1');
        fExtraction = char(extraction);
        denseSampling = true;
        folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));
        skipExisting = true;
        saveHistograms = true;
        saveLabels = saveHistograms;
        if(isdir(folderPath) && skipExisting)
            disp('Loading data');
            load(strcat(folderPath,'/classLabels'),'classLabels');
            load(strcat(folderPath,'/histograms'),'histograms');
            disp('Training SVM');
            for kernel = 0:2
                disp(kernel);
                svmOptions = strcat('-t ',kernel,' -w1 3 -b 1');
                [SVMs] = trainsvm(histograms, classLabels, categories, svmOptions);
                % to save them:
                save(strcat(folderPath,'/SVMs'),'SVMs');
            end
        else
            warning('Data not yet trained');
        end
        
        
    end
end
