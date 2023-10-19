function accuracy = test_pt_filter(net, Pt)
    total_correct = 0;
    net_filter_name = 'perceptron_filter';
    net_filter = importdata(net_filter_name + ".mat");
    for i=1:size(Pt, 2)
        classification = net(net_filter(Pt(:,i)));
        number = find(classification == max(classification),1);
        if number == rem(i-1, 10) + 1
            total_correct = total_correct + 1;
        % else
            % display(rem(i-1, 10) + 1 + " " + number);
        end
    end
    accuracy = total_correct/size(Pt, 2);
    %display(accuracy);
end