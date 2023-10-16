function create_net_filter()
    load('PerfectArial.mat', 'Perfect');
    load('P.mat', 'P');
    P = double(P);
    T = repmat(Perfect, 1, 50);
    % W=-1 + 2.*rand(256,256);
    Wp = T * pinv(P);
    net_filter = network(1, 1, 0, 1, 0, 1);
    net_filter.layers{1}.size = 256;
    net_filter.inputs{1}.size = 256;
    net_filter.IW{1} = Wp;
    net_filter.layers{1}.transferFcn = 'purelin';
    %{
    net_filter.performParam.lr = 0.5;
    net_filter.performFcn = 'sse';
    net_filter.trainFcn='trainb';
    net_filter.adaptFcn='learnp';
    net_filter.trainParam.epochs = 1000;
    net_filter.trainParam.show = 35;
    net_filter.trainParam.goal = 1e-6;
    % net_2layer_softmax_extra.trainParam.min_grad = 1e-6;
    % net_2layer_softmax_extra.trainParam.max_fail = 10;
    [trainInd,valInd,testInd] = divideind(500,1:425,426:500,[]);
    net_filter.divideFcn = 'divideind';
    net_filter.divideParam.trainInd = trainInd;
    net_filter.divideParam.valInd = valInd;
    net_filter.divideParam.testInd = testInd;
    net_filter = train(net_filter,P,T);
    %}
    save net_filter.mat net_filter;
end