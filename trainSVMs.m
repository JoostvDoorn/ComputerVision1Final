% This script trains the SVMs
denseSettings = [ true, false ];
vocSizes = [ 400, 800, 1600, 2000, 4000 ];
extractions = { 'grayscaleSift','colorSift','rgbSift','opponentSift','hsvSift' };
for denseSampling=denseSettings
    for extraction=extractions,
        for voc=vocSizes,
            categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
            vocSize = voc;
            trainingSize = 'max';
            visualVocBuildingSize = 250;
            fExtraction = char(extraction);
            folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));
            if(isdir(folderPath))
                disp('Loading data');
                load(strcat(folderPath,'/classLabels'),'classLabels');
                load(strcat(folderPath,'/histograms'),'histograms');
                disp('Training SVM');
                for kernel = 0:2
                    disp(kernel);
                    svmOptions = strcat('-t ',num2str(kernel),' -w1 3 -b 1');
                    [SVMs] = trainsvm(histograms, classLabels, categories, svmOptions);
                    % to save them:
                    save(strcat(folderPath,'/SVMs',num2str(kernel)),'SVMs');
                end
            else
                warning('Data not yet trained');
                warning(folderPath);
            end


        end
    end
end