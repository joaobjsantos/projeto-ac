function train_net_2layer_softmax_extra()
    load('P.mat', 'P');
    P = filter_input(P);
    T = zeros(10,500);
    for i = 1:500
        % create a 10:1 zeros vector with a 1 on the current target number
        current_target = zeros(10,1);
        current_target(rem(i-1,10)+1) = 1;
        T(:,i) = current_target;
    end
    hidden_layer_size = 50;
    W1=-1 + 2.*rand(hidden_layer_size,256);
    b1=-1 + 2.*rand(hidden_layer_size,1); 
    W2=-1 + 2.*rand(10,hidden_layer_size);
    b2=-1 + 2.*rand(10,1); 
    W3=eye(10);
    net_2layer_softmax_extra = network(256,3,[1;1;0], ...
        [ones(1,256); zeros(1,256); zeros(1,256)], ...
        [0 0 0; 1 0 0; 0 1 0], ...
        [0 0 1]);
    net_2layer_softmax_extra.layers{1}.size = hidden_layer_size;
    net_2layer_softmax_extra.layers{2}.size = 10;
    net_2layer_softmax_extra.layers{3}.size = 10;
    net_2layer_softmax_extra.b{1} = b1;
    net_2layer_softmax_extra.b{2} = b2;
    net_2layer_softmax_extra.LW{2, 1} = W2;
    net_2layer_softmax_extra.LW{3, 2} = W3;
    for i = 1:256
        net_2layer_softmax_extra.inputs{i}.size = 1;
        net_2layer_softmax_extra.IW{1, i} = W1(:, i);
    end
    net_2layer_softmax_extra.layers{1}.transferFcn = 'logsig';
    net_2layer_softmax_extra.layers{2}.transferFcn = 'logsig';
    net_2layer_softmax_extra.layers{3}.transferFcn = 'softmax';
    net_2layer_softmax_extra.performParam.lr = 0.5;
    net_2layer_softmax_extra.performFcn = 'sse';
    net_2layer_softmax_extra.trainFcn='traingd';
    net_2layer_softmax_extra.trainParam.epochs = 2000;
    net_2layer_softmax_extra.trainParam.show = 35;
    net_2layer_softmax_extra.trainParam.goal = 1e-6;
    % net_2layer_softmax_extra.trainParam.min_grad = 1e-6;
    % net_2layer_softmax_extra.trainParam.max_fail = 10;
    [trainInd,valInd,testInd] = divideind(500,1:425,426:500,[]);
    net_2layer_softmax_extra.divideFcn = 'divideind';
    net_2layer_softmax_extra.divideParam.trainInd = trainInd;
    net_2layer_softmax_extra.divideParam.valInd = valInd;
    net_2layer_softmax_extra.divideParam.testInd = testInd;
    net_2layer_softmax_extra = train(net_2layer_softmax_extra,P,T);
    save net_2layer_softmax_extra.mat net_2layer_softmax_extra;
end