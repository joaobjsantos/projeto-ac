function train()
    load('PerfectArial.mat', 'Perfect');
    load('P.mat', 'P');
    T = zeros(10,500);
    for i = 1:500
        % create a 10:1 zeros vector with a 1 on the current target number
        current_target = zeros(10,1);
        current_target(rem(i-1,10)+1) = 1;
        T(:,i) = current_target;
    end
    W=-1 + 2.*rand(10,256);
    b=-1 + 2.*rand(10,1); 
    net = network(256,1,[1], ones(1,256), [0], [1]);
    net.layers{1}.size = 10;
    net.b{1} = b;
    for i = 1:256
        net.inputs{i}.size = 1;
        net.IW{1, i} = W(:, i);
    end
    net.layers{1}.transferFcn = 'hardlim';
    net.performParam.lr = 0.5;
    net.performFcn = 'sse';
    net.trainFcn='trainc';
    net.trainParam.epochs = 1000;
    net.trainParam.show = 35;
    net.trainParam.goal = 1e-6;
    net = train(net,P,T);
    save net.mat net;
end

%{
    W=-1 + 2.*rand(10,256);
    b=-1 + 2.*rand(10,1); 
    net.IW{1,1}=W;
    net.b{1,1}= b;
%}