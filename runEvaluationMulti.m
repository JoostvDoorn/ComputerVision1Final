% runEvaluationMutli.m
% This script evaluates multiple models using test data from the test set.
% Models to evaluate need to be specified in the parameters below.
% The script will look for the model in the result directory and evaluate
% it if found.

% parameters to specify %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vocSizes = [ 400, 800, 1600, 2000, 4000 ];
extractions = { 'grayscaleSift', 'colorSift', 'rgbSift', 'opponentSift', 'hsvSift'};
categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
denseSampling = false;
trainingSize = 'max';
visualVocBuildingSize = 250;
svmKernels = [0,1,2];
N = 'max';
testData = getData(categories, 'test', N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run the evaluation for different parameter combinations
for extraction=extractions,
    for voc=vocSizes,
        vocSize = voc;
        fExtraction = char(extraction);

        % Find directory and check if it exists
        folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));

        if(isdir(folderPath))
            
            disp(strcat({'Evaluating  '}, folderPath));
            
            % check if histogramsEval and classLabelsEval exist
            
            disp(strcat(folderPath,'/histogramsEval',num2str(N)));
            
            if(exist(strcat(folderPath,'/histogramsEval',num2str(N),'.mat'), 'file') && exist(strcat(folderPath,'/classLabelsEval',num2str(N),'.mat'), 'file'))
            
             
                disp('histograms found.');
                % load test data for evaluation
                load(strcat(folderPath,'/histogramsEval',num2str(N)));
                load(strcat(folderPath,'/classLabelsEval',num2str(N)));

            else    
                
                % calculate test histograms as they do not
                % exist yet
                
                load(strcat(folderPath,'/centers'),'centers');

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
                
                % save test histograms and labels for further use
                save(strcat(folderPath,'/histogramsEval',num2str(N)),'histogramsEval');
                save(strcat(folderPath,'/classLabelsEval',num2str(N)),'classLabelsEval');

            end
            
            % histograms ready
            
            % evalaute test data for each kernel
            for svmKernel=svmKernels,
                
                svmFile = strcat(strcat(folderPath, '\SVMs'), num2str(svmKernel));
                
                if exist(strcat(svmFile, '.mat'), 'file')
                    
                    disp(strcat({'Evaluating SVM file '}, svmFile));
                
                    load(svmFile, 'SVMs');

                    averagePrecision = evaluate(categories, classLabelsEval, histogramsEval, SVMs);
                    
                    % The following line is for our own use to output data
                    % in LaTeX tables.
                    
                    addToResultTable( vocSize, fExtraction, denseSampling, averagePrecision, svmKernel );
                    
                    disp(strcat('average precisions for kernel= ', num2str(svmKernel), {': '}, num2str(averagePrecision)));
                    
                else
                    warning(strcat('SVM model not found: ', svmFile));
                    
                end
                
            end
            
        else
            warning(strcat('Instance not found: ', folderPath));
            
        end
    end
end