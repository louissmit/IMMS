function [ model ] = trainSVM( workingDir, locations, centers, k)
%TRAINSVM Summary of this function goes here
%   Detailed explanation goes here
    setSize = 100;
    nrOfTrainImages = setSize * 4;
    trainData = zeros(nrOfTrainImages,400);
    trainLabels = zeros(nrOfTrainImages,1);
    trainLabels(1:setSize) = 1;

    x = 1;
    for l = 1:length(locations)
        for j = 1:setSize
            directory = strcat(workingDir, locations{l}, 'train');
            imageNames = dir(fullfile(directory,'*.jpg'));
            imageNames = {imageNames.name};
            image = im2double(imread(fullfile(directory,imageNames{j})));
            if(size(image,3) == 3)
                image = rgb2gray(image);
            end
            [frames, desc] = vl_sift(single(image));
            indices = vl_ikmeanspush(desc,centers);
            H = vl_ikmeanshist(k,indices);
            trainData(x,:) = reshape(H, 1, 400);
            x = x+1;
    %         figure;
    %         bar(H);
        end
    end

    model = svmtrain(trainLabels, trainData);
    save('model.mat', 'model');

end
