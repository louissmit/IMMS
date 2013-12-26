workingDir = 'data/';
locations = {'airplanes_', 'cars_','faces_', 'motorbikes_'};

params.k = 400;
params.kernel = '';
params.sift_type = 'grey_scale';%['grey_scale' , 'rgb', 'opponent'];
params.dense = 0;%[true, false];
params.setSize = 1000;

[trainingSet, testSet] = loadData(workingDir, locations, params);

centers = loadCodebook(trainingSet, params);
% load('clusters.mat');

trainSetSize = [12];%[200, 400, 800, 1600];



for positiveSet = 1:4
    for setSize = trainSetSize
        params.setSize = setSize;
        model = getModel(trainingSet, centers, positiveSet, params);
        results = runClassifier(workingDir, locations, centers, model, positiveSet, params);
    end
end
