function [sensitivity, specificity, sensetivityPreictal] = performance(Trg_test, predicted,errorWeigths)

TP = 0;
TN = 0;
FP = 0;
FN = 0;
FNpre = 0;
TPpre = 0;

if errorWeigths==1  %1-errorWeigths for Ictal 
predicted(3,:)=predicted(3,:)*2.03;
elseif errorWeigths==2  %2-errorweigths for Preictal
predicted(2,:)=predicted(2,:)*2.2;
else
    predicted(2,:)=predicted(2,:)*2;
    predicted(3,:)=predicted(3,:)*2;
end

for i = 1:length(predicted(1,:))
    [~, maxIndextrg] = max(Trg_test(:,i));
    [~, maxIndex] = max(predicted(:,i));
    if maxIndextrg == 1 %interictal
        if maxIndex == 3
            FP = FP+1;
        else
            TN = TN +1;
        end
    elseif maxIndextrg == 2 %preictal
        if maxIndex==1 || maxIndex==3
            FNpre = FNpre+1;
        else 
           TPpre=TPpre+1;
        end
    else
        if maxIndex==1 || maxIndex ==2
            FN=FN+1;
        else
            TP=TP+1;
        end
    end
end

sensitivity = (TP)/(TP+FN)*100;
specificity = (TN)/(TN+FP)*100;
sensetivityPreictal = (TPpre)/(TPpre+FNpre)*100;

end