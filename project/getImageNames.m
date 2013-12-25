function [ directory, imageNames ] = getImageNames( workingDir, location ,type)
%GETIMAGENAMES Summary of this function goes here
%   Detailed explanation goes here
    directory = strcat(workingDir, location, type);
    imageNames = dir(fullfile(directory,'*.jpg'));
    imageNames = {imageNames.name};
end

