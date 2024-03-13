function [Pbalanced,target,test, testTarget] = balance_LSTM(P, T)
    T = T';
    countSeizures = 0;
    last=1;
    Pbalanced=[];
    target=[];
    test=[];
    testTarget=[];
    for i = 1:length(P(1,:))
        if T(i)==3%ictal
            if T(i)~=last
                countSeizures = countSeizures + 1;
            end
        end
        last=T(i);
    end

    numSeiruzerInput = floor(countSeizures*0.8);
    seizuresAdded=0;
    endSeizure=0;
    startSeizure=0;
    for i = 1:length(P(1,:))
        if T(i)==2 && T(i)~=last %start of seizure
            startSeizure=i;
        end
        if T(i)==1 && T(i)~=last%end of seizure
            endSeizure = i;
        end
        last=T(i);
        if endSeizure~=0 && startSeizure ~=0
            if seizuresAdded<=numSeiruzerInput
                Pbalanced=[Pbalanced P(:,startSeizure-200:endSeizure+200)];
                target=[target T(:,startSeizure-200:endSeizure+200)];
                seizuresAdded=seizuresAdded+1;
            else
                test=[test P(:,startSeizure-200:endSeizure+200)];
                testTarget=[testTarget T(:,startSeizure-200:endSeizure+200)];
            end
            endSeizure=0;
            startSeizure=0;
        end
    end
    Pbalanced=num2cell(Pbalanced,1);
    test=num2cell(test,1);
end