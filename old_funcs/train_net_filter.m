function train_net_filter()
    load('PerfectArial.mat', 'Perfect');
    load('P.mat', 'P');
    T = repmat(Perfect, 1, 50);
    W=-1 + 2.*rand(256,256);
    b=-1 + 2.*rand(256,1); 
    net_filter = network(256,1,[1], ones(1,256), [0], [1]);
    net_filter.layers{1}.size = 256;
    net_filter.b{1} = b;
    for i = 1:256
        net_filter.inputs{i}.size = 1;
        net_filter.IW{1, i} = W(:, i);
    end
    net_filter.layers{1}.transferFcn = 'hardlim';
    net_filter.performParam.lr = 0.5;
    net_filter.performFcn = 'sse';
    net_filter.trainFcn='trainc';
    net_filter.adapFcn='learnpf';
    net_filter.trainParam.epochs = 1000;
    net_filter.trainParam.show = 35;
    net_filter.trainParam.goal = 1e-6;
    net_filter = train(net_filter,P,T);
    save net_filter.mat net_filter;
end