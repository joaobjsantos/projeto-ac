function train_and_test_2layer()
    for h=[10,15,20,25,50,100,150,200,256]
        fprintf("%d\n\n", h);
        for i=1:5
            train_net_2layer_softmax(h);
            load("net_2layer_softmax.mat");
            load("P.mat");
            %T = repmat(eye(10), 1, 50);
            %load("Pt.mat");
            %net_2layer_softmax = patternnet(h);
            %net_2layer_softmax = train(net_2layer_softmax, P, T);
            if i == 5
                fprintf("%.2f\n", test_pt_no_filter(net_2layer_softmax, Pt));
            else
                fprintf("%.2f, ", test_pt_no_filter(net_2layer_softmax, Pt));
            end
        end
        fprintf("\n");
    end
end