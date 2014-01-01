function codebook = loadCodebook(trainingSet, params)
%loadCodebook Summary of this function goes here
%   Detailed explanation goes here
    path = strcat('codebooks/k',num2str(params.k),'setSize', num2str(params.codeSetSize),'sift_type', params.sift_type,'dense', num2str(params.dense));
    if ~exist(strcat(path, '.mat'),'file')
        disp('generating codebook...');
        nrOfImages = params.codeSetSize / length(trainingSet.class);
        data = [];
        for i = 1:length(trainingSet.class)
            for j = 1:nrOfImages
                data = horzcat(data, trainingSet.class(i).image(j).desc);
            end
        end

        [centers, ~] = vl_ikmeans(data, params.k);
        save(path, 'centers');
        codebook = centers;
    else
        S = load(path, 'centers');
        codebook = S.centers;
    end
end

