function test_pt_filter(net, Pt)
    total_correct = 0;
    load('net_filter.mat', 'net_filter');
    for i=1:size(Pt, 2)
        classification = net(net_filter(Pt(:,i)));
        number = find(classification == max(classification),1);
        if number == rem(i-1, 10) + 1
            total_correct = total_correct + 1;
        else
            display(rem(i-1, 10) + 1 + " " + number);
        end
    end
    display(total_correct/size(Pt, 2));
end