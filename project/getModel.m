function model = getModel(trainingSet, codebook, positiveSet, params);
%TRAINSVM Summary of this function goes here
%   Detailed explanation goes here
    path = strcat('models/',num2str(positiveSet),'/setSize',num2str(params.setSize), 'k',num2str(params.k),'sift',params.sift_type, 'dense', num2str(params.dense));
    if(params.kernel ~= 2)
        path = strcat(path, 'kernel', num2str(params.kernel));
    end
    if ~exist(strcat(path, '.mat'),'file')
        nrOfTrainImages = params.setSize / length(trainingSet.class);
        trainData = zeros(params.setSize, params.k);
        trainLabels = -1 * ones(params.setSize,1);

        % assign positve labels     
        trainLabels(((positiveSet-1)*nrOfTrainImages+1):(nrOfTrainImages*positiveSet)) = 1;
        x = 1;
        
        for i = 1:length(trainingSet.class);
            n = size(trainingSet.class(i).image,2);
            for j = (n-nrOfTrainImages+1):n
                desc = trainingSet.class(i).image(j).desc;
                indices = vl_ikmeanspush(desc, codebook);
                H = vl_ikmeanshist(params.k,indices);
                H = 400 * (H / size(desc,2));
                trainData(x,:) = reshape(H, 1, params.k);
                x = x+1;
            end
        end
        disp('training model...');
        model = svmtrain(trainLabels, trainData, ['-t ',num2str(params.kernel)]);
        mkdir(strcat('models/', num2str(positiveSet)));
        save(path, 'model');

    else
        disp('loading model...');
        load(path, 'model');
    end
end

