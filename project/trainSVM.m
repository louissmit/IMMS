function [ model ] = trainSVM(workingDir, locations,sift_type, dense, centers, k, setSize, positiveSet)
%TRAINSVM Summary of this function goes here
%   Detailed explanation goes here
    nrOfTrainImages = setSize / 4;
    trainData = zeros(setSize, k);
    trainLabels = zeros(setSize,1);

    % assign positve labels     
    trainLabels(((positiveSet-1)*nrOfTrainImages+1):(nrOfTrainImages*positiveSet)) = 1;

    x = 1;
    for l = 1:length(locations)
        [directory, imageNames] = getImageNames( workingDir, locations{l}, 'train');
        n = size(imageNames,2);
        for j = (n-nrOfTrainImages+1):n
            desc = getSift(directory, imageNames, j, sift_type, logical(dense));
            indices = vl_ikmeanspush(desc,centers);
            H = vl_ikmeanshist(k,indices);
            trainData(x,:) = reshape(H, 1, k);
            x = x+1;
        end
    end

    model = svmtrain(trainLabels, trainData);
    mkdir(strcat('models/', num2str(positiveSet)));
    save(strcat('models/',num2str(positiveSet),'/setSize',num2str(setSize), 'k',num2str(k),'sift',sift_type, 'dense', num2str(dense), '.mat'), 'model');

end

