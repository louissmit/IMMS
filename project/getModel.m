function model = getModel(trainingSet, codebook, positiveSet, params);
%TRAINSVM Summary of this function goes here
%   Detailed explanation goes here
    path = strcat('models/',num2str(positiveSet),'/setSize',num2str(params.setSize), 'k',num2str(params.k),'sift',params.sift_type, 'dense', num2str(params.dense), '.mat')
    
    if ~exist(path,'file')
        nrOfTrainImages = params.setSize / length(trainingSet.class);
        trainData = zeros(params.setSize, params.k);
        trainLabels = zeros(params.setSize,1);

        % assign positve labels     
        trainLabels(((positiveSet-1)*nrOfTrainImages+1):(nrOfTrainImages*positiveSet)) = 1;
        x = 1;
        
        for i = 1:length(trainingSet.class);
            n = size(trainingSet.class(i).image,2);
            for j = (n-nrOfTrainImages+1):n
                desc = trainingSet.class(i).image(j).desc;
                indices = vl_ikmeanspush(desc, codebook);
                H = vl_ikmeanshist(params.k,indices);
                trainData(x,:) = reshape(H, 1, params.k);
                x = x+1;
            end
        end
        model = svmtrain(trainLabels, trainData);
        mkdir(strcat('models/', num2str(positiveSet)));
        save(path, 'model');

    else
        S = load(path);
        model = S.model;
    end
    
%     for l = 1:length(locations)
%         [directory, imageNames] = getImageNames( workingDir, locations{l}, 'train');
%         n = size(imageNames,2);
%         % use images at the tail for training
%         for j = (n-nrOfTrainImages+1):n
%             desc = getSift(directory, imageNames{j}, sift_type, logical(dense));
%             indices = vl_ikmeanspush(desc,centers);
%             H = vl_ikmeanshist(k,indices);
%             trainData(x,:) = reshape(H, 1, k);
%             x = x+1;
%         end
%     end


end

