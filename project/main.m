workingDir = 'data/';
locations = {'airplanes_', 'cars_','faces_', 'motorbikes_'};

k = 400;
kernel = '';
sift_type = 'grey_scale';%['grey_scale' , 'rgb', 'opponent'];
dense = 0;%[true, false];
trainSetSize = [200, 400, 800, 1600];
% writeClusters(workingDir, locations, trainSetSize, k, 'clusters.mat');
load('clusters.mat');


for positiveSet = 1:4
    for setSize = trainSetSize
        trainSVM( workingDir, locations,sift_type, dense, centers, k, setSize, positiveSet);
    end
end

% load(strcat('models/',num2str(positiveSet),'/setSize',num2str(trainSetSize), 'k',num2str(k),'sift',sift_type, 'dense', num2str(dense), '.mat'), 'model');

% results = runClassifier(workingDir, locations,sift_type, dense, centers, k, model, positiveSet);

