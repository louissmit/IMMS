workingDir = 'data/';
locations = {'airplanes_', 'cars_','faces_', 'motorbikes_'};
nrOfImages = 5;
data = [];
for l = 1:length(locations)
    directory = strcat(workingDir, locations{l}, 'train');
    imageNames = dir(fullfile(directory,'*.jpg'));
    imageNames = {imageNames.name};
    for i = 1:nrOfImages
        image = rgb2gray(im2double(imread(fullfile(directory,imageNames{i}))));
        [frames, desc] = vl_sift(single(image));
        data = horzcat(data, desc); 
    end
end

k = 400;
[centers, assignments] = vl_ikmeans(data, k);

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
