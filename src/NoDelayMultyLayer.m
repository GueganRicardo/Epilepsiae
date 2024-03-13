function [network,perf] = NoDelayMultyLayer(P, T,balance,errorWeigths,train_test,NN_name)    
    net = feedforwardnet([50 10], "traingd");

    
    if balance == 1
        [ictal ,preictal ,interictal] = class_separator(P,T);
        section = floor(length(ictal)*0.8);
        total = length(P(1,:));
        input=[ictal(:,1:section) preictal(:,1:section), interictal(:,1:section*2)];
        test=[ictal(:,section+1:length(ictal)) preictal(:,section+1:length(preictal)) interictal(:,section*2+1:length(interictal))];
        targetInput=zeros(3,section*4);
        targetInput(3,1:section) = 1;
        targetInput(2,section+1:section*2) = 1;
        targetInput(1,section*2+1:section*4) = 1;
        targetTest=zeros(3,total-section*4);
    else
        input = P(:,1:floor(length(P(1,:)*0.8)));
        test = P(:,floor(length(P(1,:)*0.8):length(P(1,:))));
        targetInput = T(:,1:floor(length(P(1,:)*0.8)));
        targetTest= T(:,floor(length(P(1,:)*0.8):length(P(1,:))));
    end
    if train_test
        network = train(net, input, targetInput);
    else
        path = "../NN/"+NN_name;
        network = load(path);
    end
    testOutput=network(input);
    [sens, spec, senspre]  = performance(targetInput,testOutput,errorWeigths);
    perf = [sens spec senspre] ;
    
end