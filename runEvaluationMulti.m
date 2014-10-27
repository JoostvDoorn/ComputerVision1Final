% This script trains the SVMs
vocSizes = [ 400, 800, 1600, 2000, 4000 ];
extractions = { 'rgbSift' };
categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
denseSampling = false;
trainingSize = 'max';
visualVocBuildingSize = 250;
svmCodes = [1,2,3];

testData = getData(categories, 'test', 2);

for extraction=extractions,
    for voc=vocSizes,
        vocSize = voc;
        fExtraction = char(extraction);

        folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));
        saveHistograms = true;
        saveLabels = saveHistograms;
        if(isdir(folderPath))
            
            disp(strcat('Evaluating  ', folderPath));
            
            % check if histogramsEval  and classLabelsEval exist
            
            disp(strcat(folderPath,'/histogramsEval'));
            
            if(exist(strcat(folderPath,'/histogramsEval.mat'), 'file') && exist(strcat(folderPath,'/classLabelsEval.mat'), 'file'))
            
             
            disp('histograms found.');
               
            load(strcat(folderPath,'/histogramsEval'));
            load(strcat(folderPath,'/classLabelsEval'));
                
            
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
              
            save(strcat(folderPath,'/histogramsEval'),'histogramsEval');
            save(strcat(folderPath,'/classLabelsEval'),'classLabelsEval');
            
            end
            
            % histograms ready
            
            for svmCode=svmCodes,
                
                svmFile = strcat(strcat(folderPath, '\SVMs'), num2str(svmCode));
                
                if exist(strcat(svmFile, '.mat'), 'file')
                    
                    disp(strcat('Evaluating SVM file ', svmFile));
                
                    load(svmFile, 'SVMs');

                    MAP = evaluate(categories, classLabelsEval, histogramsEval, SVMs);
                    addToResultTable( vocSize, fExtraction, denseSampling, MAP, num2str(smvCode) );
                    
                else
                    warning(strcat('SVM model not found: ', svmFile));
                    
                end
                
            end
            
        else
            warning(strcat('Instance not found: ', folderPath));
            
        end
    end
end