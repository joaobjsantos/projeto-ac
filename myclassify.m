function Y = myclassify(X, filled_inx)
    display("Hello World " + filled_inx);
    display(X(filled_inx));
    Y = zeros(1, filled_inx);
    load('net.mat', 'net');
    for inx = filled_inx
        Y = [Y, net(X(inx))];
    end
    %display(Y(1));
end