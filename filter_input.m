function P2 = filter_input(P1)
    load('PerfectArial.mat', 'Perfect');
    load('P.mat', 'P');
    T = repmat(Perfect, 1, 50);
    P2 = T*pinv(P)*P1;
end