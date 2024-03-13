function [net,performance] = ConvolutionalNeuralNetwork(P,T,overlap,balance,errorWeights,train_test,NN_name)
    sizeImages = length(P(:,1));
    [ictal ,preictal ,interictal] = class_separator(P,T);
    [imagesIctal, targetIctal] = BuildImages(ictal,overlap,3);
    [imagesPreIctal, targetPreictal] = BuildImages(preictal,overlap,2);
    [imagesInterIctal, targetInterictal] = BuildImages(interictal,overlap,1);
    
    
    if balance==1
        [input,test,inputAmount] = balance_CNN(imagesIctal,imagesPreIctal,imagesInterIctal);
        labelsP=[targetIctal(1:inputAmount,:)' targetPreictal(1:inputAmount,:)' targetInterictal(1:inputAmount*2,:)'];
        labelsTest = [targetIctal(inputAmount+1:length(targetIctal),:)' targetPreictal(inputAmount+1:length(targetPreictal),:)' targetInterictal(inputAmount*2+1:length(targetInterictal),:)'];
        target = categorical(labelsP, [1,2,3], {'Interictal', 'Preictal', 'Ictal'});
        testTarget = categorical(labelsTest, [1,2,3], {'Interictal', 'Preictal', 'Ictal'});
    else
        input = [];
        input = cat(4, input,imagesIctal);
        input = cat(4, input,imagesPreIctal);
        input = cat(4, input,imagesInterIctal);
        test=input;
        labels=[targetIctal' targetPreictal' targetInterictal'];
        target = categorical(labels, [1,2,3], {'Interictal', 'Preictal', 'Ictal'});
        testTarget=target;
    end

    if errorWeights == 1
        weights = [2 10 20];
    else 
        weights = [1 1 1];
    end



    layers = [
        imageInputLayer([sizeImages sizeImages 1])
        convolution2dLayer(5, 20)
        swishLayer %
        maxPooling2dLayer(2, "Stride", 2)%do not talk
        fullyConnectedLayer(3)
        softmaxLayer
        classificationLayer('Classes', {'Interictal', 'Preictal', 'Ictal'}, 'ClassWeights', weights) % Output layer for classification
    ];

    % Train the ne
    % twork
       
    options = trainingOptions('sgdm', 'MaxEpochs', 100, 'MiniBatchSize', 64);
    if train_test
        net = trainNetwork(input, target, layers, options);
    else
        path = NN_name;
        net = load(path);
    end
    
    result = classify(net, test);
    [sensitivity, specificity, sensetivityPreictal]  = performanceByClass(testTarget,result);
    performance=[sensitivity, specificity,sensetivityPreictal];
end

