function create_net_filter()
    load('PerfectArial.mat', 'Perfect');
    load('P.mat', 'P');
    T = repmat(Perfect, 1, 50);
    Wp = T * pinv(P);
    net_filter = network(1, 1, 0, 1, 0, 1);
    net_filter.layers{1}.size = 256;
    net_filter.inputs{1}.size = 256;
    net_filter.IW{1} = Wp;
    net_filter.layers{1}.transferFcn = 'purelin';
    save net_filter.mat net_filter;
end