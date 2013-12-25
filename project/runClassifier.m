function [ result ] = runClassifier(workingDir, locations,sift_type, dense, centers, k, model, positiveSet)
%RUNCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

    nrOfTestImages = 200;
    testData = zeros(nrOfTestImages,400);
    testLabels = zeros(nrOfTestImages,1);
    testLabels(1:50) = 1;

    x = 1;
    for l = 1:length(locations)
        [directory, imageNames] = getImageNames( workingDir, locations{l}, 'test');
        for j = 1:50
            desc = getSift(directory, imageNames, j, sift_type, logical(dense));
            indices = vl_ikmeanspush(desc,centers);
            H = vl_ikmeanshist(k,indices);
            testData(x,:) = reshape(H, 1, 400);
            x = x+1;
        end
    end
    
    [predict_label, accuracy, prob_values] = svmpredict(testLabels, testData, model);
    result = [testLabels, prob_values];
    result = sortrows(result, -2);
end

