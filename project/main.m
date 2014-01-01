addpath('libsvm-3.17/matlab');

workingDir = 'data/';
locations = {'airplanes_', 'cars_','faces_', 'motorbikes_'};
testNames = [];
for l = 1:length(locations)
    [~, imageNames] = getImageNames( workingDir, locations{l}, 'test');
    imageNames = reshape(strcat(locations{l},'/', imageNames), 50, 1);
    testNames = [testNames ; imageNames];
end
params.testNames = testNames;


params.k = 400;
params.sift_type = 'opponent';
params.dense = 0;%[true, false];
params.codeSetSize = 400;
params.kernel = 2;

params.setSize = 600;
% %run heuristic "best" experiment
% [trainingSet, testSet] = loadData(workingDir, locations, params);
% [results, map] = runExperiment(trainingSet, testSet, params);

% back to baseline parametsrs
params.sift_type = 'grey_scale';
params.setSize = 400;
% trainSetSizes = [200, 600, 800, 1000];
results = [];
x = 1;
% run experiment for different vocabulary sizes.
Ks = [400, 800, 1600];%, 2000 ,4000];
kees = {'K=400','K=800','K=1600'};
[trainingSet, testSet] = loadData(workingDir, locations, params);
for k = Ks
    params.k = k;
    [~, map] = runExperiment(trainingSet, testSet, params);
    results(x) = map;
    x = x+1;
end
params.k = 400;


% run experiment for different sift descriptor types
sift_types = {'grey_scale', 'rgb', 'nrgb', 'opponent'};
sift_types = {'grey_scale', 'rgb', 'opponent'};
for s = 1:size(sift_types,2)
    params.sift_type = sift_types{s};
    [trainingSet, testSet] = loadData(workingDir, locations, params);
    [~, map] = runExperiment(trainingSet, testSet, params)
    results(x) = map;
    x = x+1;
end


params.sift_type = 'grey_scale';

% run experiment for different SVM kernels
kernels = {'linear', 'polynomial', 'RBF', 'sigmoid'};
[trainingSet, testSet] = loadData(workingDir, locations, params);
for s = 1:size(kernels,2)
    params.kernel = s-1;
    [~, map] = runExperiment(trainingSet, testSet, params)
    results(x) = map;
    x = x+1;
end

figure; barh(results);
yLabels = cat(2, kees, sift_types, kernels);
set(gca, 'YTickLabel', yLabels);