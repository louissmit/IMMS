function result = runClassifier(testSet, model, codebook, positiveSet, params)
%RUNCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

    testSetSize = 200;
    nrOfTestImages = testSetSize / length(testSet.class);
    testData = zeros(testSetSize, params.k);
    testLabels = -1 * ones(testSetSize,1);

    % assign positve labels     
    testLabels(((positiveSet-1)*nrOfTestImages+1):(nrOfTestImages*positiveSet)) = 1;
    x = 1;
    
    for i = 1:length(testSet.class)
        n = size(testSet.class(i).image,2);
        for j = 1:n
            desc = testSet.class(i).image(j).desc;
            indices = vl_ikmeanspush(desc, codebook);
            H = vl_ikmeanshist(params.k,indices);
            % normalize histogram
            H = 400 * (H / size(desc,2));
            testData(x,:) = reshape(H, 1, params.k);
            x = x+1;
        end
    end
    disp('running classifier...');
    [predict_label, accuracy, prob_values] = svmpredict(testLabels, testData, model);
    indices = reshape([1:testSetSize], testSetSize, 1);
    result = [testLabels, prob_values, indices];
    result = sortrows(result, -2);
    % to get list of image names
    imageRanking = params.testNames(result(:,3));
end

