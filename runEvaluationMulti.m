% This script trains the SVMs
vocSizes = [ 400, 800, 1600, 2000, 4000 ];
extractions = { 'colorSift' };
categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
denseSampling = false;
trainingSize = 'max';
visualVocBuildingSize = 250;
svmCodes = [0,1,2];
N = 'max';
testData = getData(categories, 'test', N);

for extraction=extractions,
    for voc=vocSizes,
        vocSize = voc;
        fExtraction = char(extraction);

        folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));
        saveHistograms = true;
        saveLabels = saveHistograms;
        if(isdir(folderPath))
            
            disp(strcat({'Evaluating  '}, folderPath));
            
            % check if histogramsEval  and classLabelsEval exist
            
            disp(strcat(folderPath,'/histogramsEval',num2str(N)));
            
            if(exist(strcat(folderPath,'/histogramsEval',num2str(N),'.mat'), 'file') && exist(strcat(folderPath,'/classLabelsEval',num2str(N),'.mat'), 'file'))
            
             
                disp('histograms found.');

                load(strcat(folderPath,'/histogramsEval',num2str(N)));
                load(strcat(folderPath,'/classLabelsEval',num2str(N)));

            else    
                
                load(strcat(folderPath,'/centers'),'centers');
                load(strcat(folderPath,'/classLabels'),'classLabels');
                load(strcat(folderPath,'/histograms'),'histograms');

                % visual descriptions
                c = 0;
                classLabelsEval = [];
                histogramsEval = [];
                disp('Get visual descriptions');
                % Build the visual vocabulary for the test data
                for category = categories
                    disp(char(category));
                    images = getfield(testData, char(category));
                    visualDescriptions = getVisualDescriptions(images, centers, fExtraction, denseSampling);
                    classLabelsEval = [ classLabelsEval ; repmat( c, [size(visualDescriptions,1), 1] )];
                    histogramsEval = [ histogramsEval ; visualDescriptions ];  
                    c = c + 1;
                end

                save(strcat(folderPath,'/histogramsEval',num2str(N)),'histogramsEval');
                save(strcat(folderPath,'/classLabelsEval',num2str(N)),'classLabelsEval');

            end
            
            % histograms ready
            
            for svmCode=svmCodes,
                
                svmFile = strcat(strcat(folderPath, '\SVMs'), num2str(svmCode));
                
                if exist(strcat(svmFile, '.mat'), 'file')
                    
                    disp(strcat({'Evaluating SVM file '}, svmFile));
                
                    load(svmFile, 'SVMs');

                    averagePrecision = evaluate(categories, classLabelsEval, histogramsEval, SVMs);
                    addToResultTable( vocSize, fExtraction, denseSampling, averagePrecision, svmCode );
                    
                else
                    warning(strcat('SVM model not found: ', svmFile));
                    
                end
                
            end
            
        else
            warning(strcat('Instance not found: ', folderPath));
            
        end
    end
end