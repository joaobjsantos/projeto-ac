function accuracy = test_pt_no_filter(net, Pt)
    total_correct = 0;
     % count the number of correct classifications
    for i=1:size(Pt, 2)
        classification = net(Pt(:,i));
        number = find(classification == max(classification),1); %choose the class with highest probability
        if number == rem(i-1, 10) + 1
            total_correct = total_correct + 1;
        end
    end
    accuracy = total_correct/size(Pt, 2);
end