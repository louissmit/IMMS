function [ centers, assigments ] = writeClusters(workingDir, locations,nrOfImages,k, filename)
%WRITECLUSTERS Summary of this function goes here
%   Detailed explanation goes here
    data = [];
    for l = 1:length(locations)
        directory = strcat(workingDir, locations{l}, 'train');
        imageNames = dir(fullfile(directory,'*.jpg'));
        imageNames = {imageNames.name};
        for i = 1:nrOfImages
            image = im2double(imread(fullfile(directory,imageNames{i})));
            if(size(image,3) == 3)
                image = rgb2gray(image);
            end
            [frames, desc] = vl_sift(single(image));
            data = horzcat(data, desc); 
        end
    end

    [centers, assignments] = vl_ikmeans(data, k);
    save(filename, 'centers', 'assignments');
end

