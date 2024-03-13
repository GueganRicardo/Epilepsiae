function [net,performance] = LongShortTermMemory(P, Trg_vector,errorWeights,balance,train_test,NN_name)
    noFeatures = size(P, 1); % Assuming all sequences have the same number of features
    noHiddenUnits = 100;

    if balance == 1
        [Plstm, labelsInput, testeInput, labelsTeste]=balance_LSTM(P,Trg_vector);
        target = categorical(labelsInput, [1, 2, 3], {'Interictal', 'Preictal', 'Ictal'});
        targetTeste = categorical(labelsTeste, [1, 2, 3], {'Interictal', 'Preictal', 'Ictal'});
    else
       division=floor(length(P(1,:))*0.8);
       all=length(P(1,:));
       Plstm =num2cell(P(:,1:division), 1);
       testeInput = num2cell(P(:,division+1:all),1);
       labelsInput = Trg_vector(1:division);
       labelsTeste = Trg_vector(division+1:all);
       target = categorical(labelsInput, [1, 2, 3], {'Interictal', 'Preictal', 'Ictal'});
       targetTeste = categorical(labelsTeste, [1, 2, 3], {'Interictal', 'Preictal', 'Ictal'});
    end

    if errorWeights == 1
        weights = [2 5 8];
    else 
        weights = [1 1 1];
    end

    

     layers = [
        sequenceInputLayer(noFeatures)
        lstmLayer(noHiddenUnits, "OutputMode","last")
        fullyConnectedLayer(3)
        softmaxLayer
        classificationLayer('Classes', {'Interictal', 'Preictal', 'Ictal'}, 'ClassWeights', weights)
        ];

    options=trainingOptions ("adam","MaxEpochs",50, "MiniBatch", 1024);
    if train_test
        net = trainNetwork(Plstm, target, layers, options);
    else
        path = "../NN/"+NN_name;
        net= load(path);
    end
    testOutput = classify(net,testeInput);
    [sensitivity, specificity, sensetivityPreictal]=performanceByClass(targetTeste,testOutput);
    performance=[sensitivity, specificity, sensetivityPreictal];
end
