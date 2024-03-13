function [sensitivity, specificity] = post_processing(Trg_test, predicted)

TP = 0;
FP = 0;
TN = 0;
FN = 0;
    
% predict
for i=1:length(predicted)-9 
    if length(find(predicted(i:i+9)==2))>=5 
        if length(find(Trg_test(i:i+9)==2))>=5
            TP=TP+1;
        else
            FP=FP+1;
        end
    else
        if length(find(Trg_test(i:i+9)==2))<5
            TN=TN+1;
        else
            FN=FN+1;
        end
    end
end

% detect
for i=1:length(predicted)-9 
    if length(find(predicted(i:i+9)==3))>=5 
        if length(find(Trg_test(i:i+9)==3))>=5
            TP=TP+1;
        else
            FP=FP+1;
        end
    else
        if length(find(Trg_test(i:i+9)==3))<5
            TN=TN+1;
        else
            FN=FN+1;
        end
    end
end



sensitivity = (TP)/(TP+FN)*100;
specificity = (TN)/(TN+FP)*100;

end