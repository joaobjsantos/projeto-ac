function Y = myclassify(X, filled_inx)
    Y = zeros(1, length(filled_inx));
    nn_name = "net_1layer_no_filter";
    net = importdata(nn_name+".mat");
    for i = 1:length(filled_inx)
        % class = net(filter_input(X(:,filled_inx(i))));
        class = net(X(:,filled_inx(i)));
        % showim(filter_input(X(:,filled_inx(i))));
        Y(i) = find(class==max(class));
    end
end