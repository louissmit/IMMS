function [results, map] = runExperiment(trainingSet, testSet, params)
    codebook = loadCodebook(trainingSet, params);
    for positiveSet = 1:4
        model = getModel(trainingSet, codebook, positiveSet, params);
        result = runClassifier(testSet, model, codebook, positiveSet, params);
        results(positiveSet).result = result;
    end
    map = getMAP(results);
end

function map = getMAP(results)
    map = 0;
    m_c = 50;
    for c = 1:length(results)
        ap = 0;
        result = results(c).result;
        f_c = 0;
        for i = 1:size(result);
            if(result(i, 1) > 0)
                f_c = f_c + 1;
                ap = ap + (f_c / i);
            end
        end
        ap = (1 / m_c) * ap
        map = map + ap;
    end
    map = map / length(results);
end