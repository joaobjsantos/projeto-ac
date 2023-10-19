function train_net_patternnet()
    load('P.mat', 'P');
    T = repmat(eye(10), 1, 50);
    net_patternnet = patternnet(25);
    net_patternnet = train(net_patternnet,P,T);
    save net_patternnet.mat net_patternnet;
end