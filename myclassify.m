function Y = myclassify(X, filled_inx)
    display("Hello World " + filled_inx);
    Y = zeros(1, length(filled_inx));
    load('net_2layer_softmax_extra.mat', 'net_2layer_softmax_extra');
    for i = 1:length(filled_inx)
        class = net_2layer_softmax_extra(filter_input(X(:,filled_inx(i))));
        showim(filter_input(X(:,filled_inx(i))));
        Y(i) = find(class==max(class));
    end
end