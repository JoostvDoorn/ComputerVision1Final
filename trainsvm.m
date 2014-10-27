function [SVMs] = trainsvm(histograms, classLabels, categories, svmOptions)
% Returns SVMs (one per class) trained on parameters given.

SVMs = struct();
% Get time at start
startTime = cputime;
disp('Train SVMs');
c = 0;
for category = categories
    disp(char(category));
    labels = ones(size(classLabels));
    labels(classLabels ~= c) = -1;
    svm = svmtrain(labels, histograms, svmOptions);
    SVMs = setfield(SVMs, char(category), svm);
    c = c + 1;
end
% Elapsed time
endTime = cputime-startTime
end
