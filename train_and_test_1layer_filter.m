function train_and_test_1layer_filter()
    for i=1:5
        train_net_1layer_filter("perceptron_filter");
        load("net_1layer_filter.mat");
        load("Pt.mat");
        if i == 5
            fprintf("%.2f\n", test_pt_filter(net_1layer_filter, Pt));
        else
            fprintf("%.2f, ", test_pt_filter(net_1layer_filter, Pt));
        end
    end
    fprintf("\n");
end