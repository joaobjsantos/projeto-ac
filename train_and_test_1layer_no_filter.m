function train_and_test_1layer_no_filter()
    for i=1:5
        train_net_1layer_no_filter();
        load("net_1layer_no_filter.mat");
        load("Pt.mat");
        if i == 5
            fprintf("%.2f\n", test_pt_no_filter(net_1layer_no_filter, Pt));
        else
            fprintf("%.2f, ", test_pt_no_filter(net_1layer_no_filter, Pt));
        end
    end
    fprintf("\n");
end