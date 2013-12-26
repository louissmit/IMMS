function codebook = loadCodebook(trainingSet, params)
%WRITECLUSTERS Summary of this function goes here
%   Detailed explanation goes here
    path = strcat('codebooks/k',num2str(params.k),'setSize', num2str(params.setSize),'sift_type', params.sift_type,'dense', num2str(params.dense));
    if ~exist(strcat(path, '.mat'),'file')
        nrOfImages = params.setSize / length(trainingSet.class);
        data = [];
        for i = 1:length(trainingSet.class)
            data = horzcat(data, trainingSet.class(i).image(1:nrOfImages).desc);
        end

        [centers, ~] = vl_ikmeans(data, params.k);
        save(path, 'centers');
    else
        S = load(path, 'centers');
        codebook = S.centers;
    end
end

