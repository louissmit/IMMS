function result = runExperiment(trainSetSizes, trainingSet, testSet, params)
    codebook = loadCodebook(trainingSet, params);
    for positiveSet = 1:4
        for setSize = trainSetSizes
            params.setSize = setSize;
            model = getModel(trainingSet, codebook, positiveSet, params);
            params.setSize = 200;
            result = runClassifier(testSet, model, codebook, positiveSet, params);
    %         disp(sum(result(1:50,1)) / 50)
        end
    end
end