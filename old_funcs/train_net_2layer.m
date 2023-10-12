function train_net_2layer()
    load('P.mat', 'P');
    P = filter_input(P);
    T = zeros(10,500);
    for i = 1:500
        % create a 10:1 zeros vector with a 1 on the current target number
        current_target = zeros(10,1);
        current_target(rem(i-1,10)+1) = 1;
        T(:,i) = current_target;
    end
    W1=-1 + 2.*rand(256,256);
    b1=-1 + 2.*rand(256,1); 
    W2=-1 + 2.*rand(10,256);
    b2=-1 + 2.*rand(10,1); 
    net_2layer = network(256,2,[1;1], [ones(1,256); zeros(1,256)], [0 0; 1 0], [0 1]);
    net_2layer.layers{1}.size = 256;
    net_2layer.layers{2}.size = 10;
    net_2layer.b{1} = b1;
    net_2layer.b{2} = b2;
    net_2layer.LW{2, 1} = W2;
    for i = 1:256
        net_2layer.inputs{i}.size = 1;
        net_2layer.IW{1, i} = W1(:, i);
    end
    net_2layer.layers{1}.transferFcn = 'purelin';
    net_2layer.layers{2}.transferFcn = 'purelin';
    net_2layer.performParam.lr = 0.5;
    net_2layer.performFcn = 'sse';
    net_2layer.trainFcn='trainscg';
    net_2layer.trainParam.epochs = 1000;
    net_2layer.trainParam.show = 35;
    net_2layer.trainParam.goal = 1e-6;
    [trainInd,valInd,testInd] = divideind(500,1:425,426:500,[]);
    net_2layer.divideFcn = 'divideind';
    net_2layer.divideParam.trainInd = trainInd;
    net_2layer.divideParam.valInd = valInd;
    net_2layer.divideParam.testInd = testInd;
    net_2layer = train(net_2layer,P,T);
    save net_2layer.mat net_2layer;
end