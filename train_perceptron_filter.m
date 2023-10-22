function train_perceptron_filter()
    load('PerfectArial.mat', 'Perfect');
    load('P.mat', 'P');
    %create target
    T = repmat(Perfect, 1, 50);
    %create neural network
    perceptron_filter = perceptron();
    [trainInd,valInd,testInd] = divideind(500,1:425,426:500,[]);
    perceptron_filter.trainFcn = 'trainc';
    perceptron_filter.adaptFcn = 'learnp';
    perceptron_filter.divideFcn = 'divideind';
    perceptron_filter.divideParam.trainInd = trainInd;
    perceptron_filter.divideParam.valInd = valInd;
    perceptron_filter.divideParam.testInd = testInd;
    perceptron_filter = train(perceptron_filter, P, T);
    save perceptron_filter.mat perceptron_filter;
end