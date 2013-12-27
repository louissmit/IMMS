workingDir = 'data/';
locations = {'airplanes_', 'cars_','faces_', 'motorbikes_'};

addpath('libsvm-3.17/matlab');

params.k = 400;
params.sift_type = 'grey_scale';
params.dense = 0;%[true, false];
params.codeSetSize = 400;

[trainingSet, testSet] = loadData(workingDir, locations, params);


% S = load('clusters.mat');
% codebook = S.centers;

trainSetSizes = [600];%[200, 400, 800, 1600];
params.kernel = '';
% Ks = [800, 1600];%, 2000 ,4000];
% for k = Ks
%     params.k = k;
%     runExperiment(trainSetSizes, trainingSet, testSet, params);
% end
% params.k = 400;

sift_types = ['rgb', 'opponent'];
for sift_type = sift_types
    params.sift_type = sift_type;
    runExperiment(trainSetSizes, trainingSet, testSet, params);
end
params.sift_type = 'grey_scale';



