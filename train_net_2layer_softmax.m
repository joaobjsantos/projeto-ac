function train_net_2layer_softmax()
    load('P.mat', 'P');
    %load('net_filter.mat', 'net_filter');
    %P = net_filter(P);
    T = repmat(eye(10), 1, 50);
    hidden_layer_size = 256;
    W1=-1 + 2.*rand(hidden_layer_size,256);
    b1=-1 + 2.*rand(hidden_layer_size,1); 
    W2=-1 + 2.*rand(10,hidden_layer_size);
    b2=-1 + 2.*rand(10,1);
    net_2layer_softmax = network(1,2,[1;1], ...
        [1; 0], ...
        [0 0; 1 0], ...
        [0 1]);
    net_2layer_softmax.layers{1}.size = hidden_layer_size;
    net_2layer_softmax.layers{2}.size = 10;
    net_2layer_softmax.b{1} = b1;
    net_2layer_softmax.b{2} = b2;
    net_2layer_softmax.LW{2, 1} = W2;
    net_2layer_softmax.inputs{1}.size = 256;
    net_2layer_softmax.IW{1} = W1;
    net_2layer_softmax.layers{1}.transferFcn = 'logsig';
    net_2layer_softmax.layers{2}.transferFcn = 'softmax';
    net_2layer_softmax.performParam.lr = 0.5;
    net_2layer_softmax.performFcn = 'sse';
    net_2layer_softmax.trainFcn='traingd';
    net_2layer_softmax.trainParam.epochs = 1000;
    net_2layer_softmax.trainParam.show = 35;
    net_2layer_softmax.trainParam.goal = 1e-6;
    % net_2layer_softmax_extra.trainParam.min_grad = 1e-6;
    % net_2layer_softmax_extra.trainParam.max_fail = 10;
    [trainInd,valInd,testInd] = divideind(500,1:425,426:500,[]);
    net_2layer_softmax.divideFcn = 'divideind';
    net_2layer_softmax.divideParam.trainInd = trainInd;
    net_2layer_softmax.divideParam.valInd = valInd;
    net_2layer_softmax.divideParam.testInd = testInd;
    net_2layer_softmax = train(net_2layer_softmax,P,T);
    save net_2layer_softmax.mat net_2layer_softmax;
end