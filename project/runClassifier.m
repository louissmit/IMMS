function [ result ] = runClassifier(workingDir, locations, centers, model, positiveSet, params)
%RUNCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

    nrOfTestImages = 50;
    testData = zeros(4 * nrOfTestImages, params.k);
    testLabels = zeros(4 * nrOfTestImages,1);
    testLabels(((positiveSet-1)*nrOfTestImages+1):(nrOfTestImages*positiveSet)) = 1;

    x = 1;
    for l = 1:length(locations)
        [directory, imageNames] = getImageNames(workingDir, locations{l}, 'test');
        for j = 1:50
            desc = getSift(directory, imageNames{j}, params.sift_type, logical(params.dense));
            indices = vl_ikmeanspush(desc,centers);
            H = vl_ikmeanshist(params.k,indices);
            testData(x,:) = reshape(H, 1, params.k);
            x = x+1;
        end
    end
    
    [predict_label, accuracy, prob_values] = svmpredict(testLabels, testData, model);
    result = [testLabels, prob_values];
    result = sortrows(result, -2);
end

