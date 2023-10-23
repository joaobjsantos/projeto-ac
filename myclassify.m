function Y = myclassify(X, filled_inx, classifier)
    % load neural network
    d = dictionary("Classifier 1" , "net_88" , "Classifier 2" , "net_86");
    Y = zeros(1, length(filled_inx));
    nn_name = d(classifier);
    net = importdata(nn_name+".mat");

    % classify drawn digits
    for i = 1:length(filled_inx)
        class = net(X(:,filled_inx(i)));
        Y(i) = find(class==max(class));
    end
end