function train_net_1layer_no_filter()
    load('P.mat', 'P');
    %create target
    T = repmat(eye(10), 1, 50);
    %initialize weights and biases
    W=-1 + 2.*rand(10,256);
    b=-1 + 2.*rand(10,1);
    %create neural network
    net_1layer_no_filter = network(1,1,1,1,0,1);
    %net_1layer_no_filter = perceptron();
    net_1layer_no_filter.layers{1}.size = 10;
    net_1layer_no_filter.b{1} = b;
    net_1layer_no_filter.inputs{1}.size = 256;
    net_1layer_no_filter.IW{1} = W;
    net_1layer_no_filter.layers{1}.transferFcn = 'logsig';
    net_1layer_no_filter.outputs{1}.processFcns = {'mapminmax'};
    net_1layer_no_filter.outputs{1}.ProcessParams{1}.ymin = 0;
    net_1layer_no_filter.outputs{1}.ProcessParams{1}.ymax = 1;
    net_1layer_no_filter.performParam.lr = 0.5;
    net_1layer_no_filter.performFcn = 'sse';
    net_1layer_no_filter.trainFcn='trainscg';
    %net_1layer_no_filter.adaptFcn='learnwh';
    net_1layer_no_filter.trainParam.epochs = 1000;
    net_1layer_no_filter.trainParam.show = 35;
    net_1layer_no_filter.trainParam.goal = 1e-6;
    % net_2layer_softmax_extra.trainParam.min_grad = 1e-6;
    % net_2layer_softmax_extra.trainParam.max_fail = 10;
    [trainInd,valInd,testInd] = divideind(500,1:425,426:500,[]);
    net_1layer_no_filter.divideFcn = 'divideind';
    net_1layer_no_filter.divideParam.trainInd = trainInd;
    net_1layer_no_filter.divideParam.valInd = valInd;
    net_1layer_no_filter.divideParam.testInd = testInd;
    net_1layer_no_filter = train(net_1layer_no_filter,P,T);
    save net_1layer_no_filter.mat net_1layer_no_filter;
end