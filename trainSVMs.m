% This script trains SVMs for the given parameters below.
% It will look for the histograms and if they exist for the given parameter
% combinations, it will train the SVMs and store them.
% Run runTrainingMutli.m with the specific parameters first to train
% histograms.

% training parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
categories = { 'airplanes' 'cars' 'faces' 'motorbikes' };
denseSettings = [ true, false ];
vocSizes = [ 400, 800, 1600, 2000, 4000 ];
extractions = { 'grayscaleSift', 'colorSift', 'rgbSift', 'opponentSift', 'hsvSift'};
trainingSize = 'max';
visualVocBuildingSize = 250;
kernels = [0, 1, 2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for denseSampling=denseSettings
    for extraction=extractions,
        for voc=vocSizes,
            vocSize = voc;
            fExtraction = char(extraction);
            folderPath = strcat('results/raw/voc',num2str(vocSize),'N',num2str(trainingSize),'M',num2str(visualVocBuildingSize),'_',fExtraction,'_dense',num2str(denseSampling));
            if(isdir(folderPath))
                disp('Loading data');
                load(strcat(folderPath,'/classLabels'),'classLabels');
                load(strcat(folderPath,'/histograms'),'histograms');
                disp('Training SVM');
                for kernel = kernels,
                    disp(kernel);
                    svmOptions = strcat({'-t '},num2str(kernel),' -w1 3 -b 1');
                    [SVMs] = trainsvm(histograms, classLabels, categories, char(svmOptions));
                    % to save them:
                    save(strcat(folderPath,'/SVMs',num2str(kernel)),'SVMs');
                end
            else
                warning(strcat('Data not yet trained: ', folderPath));
            end

        end
    end
end
