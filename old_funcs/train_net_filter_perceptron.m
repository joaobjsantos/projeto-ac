function train_net_filter_perceptron()
    load('PerfectArial.mat', 'Perfect');
    load('P.mat', 'P');
    T = repmat(Perfect, 1, 50);
    W=-1 + 2.*rand(256,256);
    b=-1 + 2.*rand(256,1);
    net_filter_perceptron = network(1, 1, 1, 1, 0, 1);
    net_filter_perceptron.layers{1}.size = 256;
    net_filter_perceptron.inputs{1}.size = 256;
    net_filter_perceptron.IW{1} = W;
    net_filter_perceptron.b{1} = b;
    net_filter_perceptron.layers{1}.transferFcn = 'hardlim';
    net_filter_perceptron.performParam.lr = 0.5;
    net_filter_perceptron.performFcn = 'sse';
    net_filter_perceptron.trainFcn='trainc';
    net_filter_perceptron.adaptFcn='learnp';
    net_filter_perceptron.trainParam.epochs = 1000;
    net_filter_perceptron.trainParam.show = 35;
    net_filter_perceptron.trainParam.goal = 1e-6;
    [trainInd,valInd,testInd] = divideind(500,1:425,426:500,[]);
    net_filter_perceptron.divideFcn = 'divideind';
    net_filter_perceptron.divideParam.trainInd = trainInd;
    net_filter_perceptron.divideParam.valInd = valInd;
    net_filter_perceptron.divideParam.testInd = testInd;
    net_filter_perceptron = train(net_filter_perceptron,P,T);
    save net_filter_perceptron.mat net_filter_perceptron;
end