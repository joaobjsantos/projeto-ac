function train_net_2layer_softmax_v2()
    load('P.mat', 'P');
    P = filter_input(P);
    T = zeros(10,500);
    for i = 1:500
        % create a 10:1 zeros vector with a 1 on the current target number
        current_target = zeros(10,1);
        current_target(rem(i-1,10)+1) = 1;
        T(:,i) = current_target;
    end
    hidden_layer_size = 20;
    W1=-1 + 2.*rand(hidden_layer_size,256);
    b1=-1 + 2.*rand(hidden_layer_size,1); 
    W2=-1 + 2.*rand(10,hidden_layer_size);
    b2=-1 + 2.*rand(10,1); 
    net_2layer_softmax_v2 = network(256,2,[1;1], ...
        [ones(1,256); zeros(1,256)], ...
        [0 0; 1 0], ...
        [0 1]);
    net_2layer_softmax_v2.layers{1}.size = hidden_layer_size;
    net_2layer_softmax_v2.layers{2}.size = 10;
    net_2layer_softmax_v2.b{1} = b1;
    net_2layer_softmax_v2.b{2} = b2;
    net_2layer_softmax_v2.LW{2, 1} = W2;
    for i = 1:256
        net_2layer_softmax_v2.inputs{i}.size = 1;
        net_2layer_softmax_v2.IW{1, i} = W1(:, i);
    end
    net_2layer_softmax_v2.layers{1}.transferFcn = 'logsig';
    net_2layer_softmax_v2.layers{2}.transferFcn = 'softmax';
    net_2layer_softmax_v2.performParam.lr = 0.5;
    net_2layer_softmax_v2.performFcn = 'sse';
    net_2layer_softmax_v2.trainFcn='traingd';
    net_2layer_softmax_v2.trainParam.epochs = 1000;
    net_2layer_softmax_v2.trainParam.show = 35;
    net_2layer_softmax_v2.trainParam.goal = 1e-6;
    net_2layer_softmax_v2.trainParam.min_grad = 1e-6;
    net_2layer_softmax_v2.trainParam.max_fail = 10;
    [trainInd,valInd,testInd] = divideind(500,1:425,426:500,[]);
    net_2layer_softmax_v2.divideFcn = 'divideind';
    net_2layer_softmax_v2.divideParam.trainInd = trainInd;
    net_2layer_softmax_v2.divideParam.valInd = valInd;
    net_2layer_softmax_v2.divideParam.testInd = testInd;
    net_2layer_softmax_v2 = train(net_2layer_softmax_v2,P,T);
    save net_2layer_softmax_v2.mat net_2layer_softmax_v2;
end