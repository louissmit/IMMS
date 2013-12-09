workingDir = 'data/';
locations = {'airplanes_train', 'cars_train','faces_train', 'motorbikes_train'};
nrOfImages = 10;
data = [];
for l = 1:length(locations)
    directory = strcat(workingDir, locations{l})
    imageNames = dir(fullfile(directory,'*.jpg'));
    imageNames = {imageNames.name};
    for i = 1:nrOfImages
        image = rgb2gray(im2double(imread(fullfile(directory,imageNames{i}))));
        [frames, desc] = vl_sift(single(image));
        size(desc)
        data = horzcat(data, desc);
        
    end
end

numClusters = 400;
[centers, assignments] = vl_ikmeans(data, numClusters);
