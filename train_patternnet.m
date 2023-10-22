function train_patternnet(h)
    load('P.mat', 'P');
    %create target
    T = repmat(eye(10), 1, 50);
    %create neural network
    net_patternnet = patternnet(h);
    net_patternnet = train(net_patternnet,P,T);
    save net_patternnet.mat net_patternnet;
end