function [trainingSet, testSet ] = loadData(workingDir, locations, params)
%LOADDATA Summary of this function goes here
%   Detailed explanation goes here
    mkdir('descriptors');
    path = strcat('descriptors/', params.sift_type, num2str(params.dense), '.mat');

    if ~exist(path, 'file')
        [trainingSet, testSet ] = compileData(workingDir, locations, params)
        save(path, 'trainingSet', 'testSet');
    else
        load(path, 'trainingSet', 'testSet');
    end

end

function [trainingSet, testSet ] = compileData(workingDir, locations, params)

    for l = 1:length(locations)
        [directory, imageNames] = getImageNames( workingDir, locations{l}, 'train');
        for j = 1:length(imageNames)
            desc = getSift(directory, imageNames{j}, params.sift_type, logical(params.dense));
            trainingSet.class(l).image(j).desc = desc;
        end
    end
    
    for l = 1:length(locations)
        [directory, imageNames] = getImageNames( workingDir, locations{l}, 'test');
        for j = 1:length(imageNames)
            desc = getSift(directory, imageNames{j}, params.sift_type, logical(params.dense));
            testSet.class(l).image(j).desc = desc;
        end
    end


end

function [ directory, imageNames ] = getImageNames( workingDir, location ,type)
%GETIMAGENAMES Summary of this function goes here
%   Detailed explanation goes here
    directory = strcat(workingDir, location, type);
    imageNames = dir(fullfile(directory,'*.jpg'));
    imageNames = {imageNames.name};
end


