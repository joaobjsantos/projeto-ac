function train_net_1layer()
    load('P.mat', 'P');
    P = filter_input(P);
    T = zeros(10,500);
    for i = 1:500
        % create a 10:1 zeros vector with a 1 on the current target number
        current_target = zeros(10,1);
        current_target(rem(i-1,10)+1) = 1;
        T(:,i) = current_target;
    end
    W=-1 + 2.*rand(10,256);
    b=-1 + 2.*rand(10,1); 
    net_1layer = network(256,1,[1], ones(1,256), [0], [1]);
    net_1layer.layers{1}.size = 10;
    net_1layer.b{1} = b;
    for i = 1:256
        net_1layer.inputs{i}.size = 1;
        net_1layer.IW{1, i} = W(:, i);
    end
    net_1layer.layers{1}.transferFcn = 'purelin';
    net_1layer.performParam.lr = 0.5;
    net_1layer.performFcn = 'sse';
    net_1layer.trainFcn='trainscg';
    net_1layer.trainParam.epochs = 1000;
    net_1layer.trainParam.show = 35;
    net_1layer.trainParam.goal = 1e-6;
    net_1layer = train(net_1layer,P,T);
    save net_1layer.mat net_1layer;
end