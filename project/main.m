workingDir = 'data/';
locations = {'airplanes_', 'cars_','faces_', 'motorbikes_'};
nrOfImages = 100;
k = 400;
% writeClusters(workingDir, locations, nrOfImages, k, 'clusters.mat');
load('clusters.mat');

setSize = 100;
nrOfTrainImages = 200;
testData = zeros(nrOfTrainImages,400);
trainLabels = zeros(nrOfTrainImages,1);
trainLabels(1:50) = 1;

x = 1;
for l = 1:length(locations)
    for j = 1:50
        directory = strcat(workingDir, locations{l}, 'test');
        imageNames = dir(fullfile(directory,'*.jpg'));
        imageNames = {imageNames.name};
        image = im2double(imread(fullfile(directory,imageNames{j})));
        if(size(image,3) == 3)
            image = rgb2gray(image);
        end
        [frames, desc] = vl_sift(single(image));
        indices = vl_ikmeanspush(desc,centers);
        H = vl_ikmeanshist(k,indices);
        testData(x,:) = reshape(H, 1, 400);
        x = x+1;
    end
end
load('model.mat');
[predict_label, accuracy, prob_values] = svmpredict(trainLabels, testData, model);
