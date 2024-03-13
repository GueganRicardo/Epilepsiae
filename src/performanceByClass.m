function [sensitivity, specificity, sensetivityPreictal] = performanceByClass(Trg_test, predicted)

TP = 0;
TN = 0;
FP = 0;
FN = 0;
FNpre = 0;
TPpre = 0;

for i=1:length(Trg_test)
    if(Trg_test(i)=="Interictal")%specificity
        if(predicted(i)=="Ictal")
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    elseif(Trg_test(i)=="Ictal")%sensitivity
        if(predicted(i)=="Interictal")
            FN = FN + 1;
        else
            TP = TP + 1;
        end 
    else
        if(predicted(i)=="Interictal")
            FNpre = FNpre + 1;
        else
            TPpre = TPpre + 1;
        end 
    end
end

sensitivity = (TP)/(TP+FN)*100;
sensetivityPreictal = (TPpre)/(TPpre+FNpre)*100;
specificity = (TN)/(TN+FP)*100;

end