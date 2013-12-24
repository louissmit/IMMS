workingDir = 'data/';
locations = {'airplanes_', 'cars_','faces_', 'motorbikes_'};
nrOfImages = 100;
k = 400;
% writeClusters(workingDir, locations, nrOfImages, k, 'clusters.mat');
load('clusters.mat');

for l = 1:length(locations)
    directory = strcat(workingDir, locations{l}, 'test');
    imageNames = dir(fullfile(directory,'*.jpg'));
    imageNames = {imageNames.name};
    image = rgb2gray(im2double(imread(fullfile(directory,imageNames{1}))));
    [frames, desc] = vl_sift(single(image));
    indices = vl_ikmeanspush(desc,centers);
    H = vl_ikmeanshist(k,indices);
    figure;
    bar(H);
end
