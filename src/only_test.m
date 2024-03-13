function only_test(NN_name,autoEncoder,number_of_features,dataSet,message)
    try
        
        load(dataSet+".mat");
         P = FeatVectSel.';
         T= Trg;
    catch ME
        message.Value = "Dataset should be on the project folder";
        return;
    end

    if autoEncoder
      encoderName = "autoEncoder"+ number_of_features+ "_"+dataSet+".mat";
      try
        encoder = load(encoderName);
        P = encode(encoder,P);
      catch ME
          message.Value = "Encoder dont not exits!";
          return;
      end
    end 

    if NN_name == "CNN"
        NN_saved= "CNN"+dataSet+".mat";
        target = prepare_data(NN_name,P,T);
        [net,performance] = ConvolutionalNeuralNetwork(P,target,10,1,1,0,NN_saved);
        message.Value = "Successful training" + newline+"Sensitivity for detecting: "+performance(1) +newline + "Specificity: " + performance(2) + newline+"Sensitivity for predicting: " + performance(3);
    elseif NN_name == "LSTM"
        NN_saved = "LSTM"+dataSet+".mat";
       target = prepare_data(NN_name,P,T); 
       [net,performance] = LongShortTermMemory(P, T,1,1,0,NN_saved);
       message.Value = "Successful training" + newline+"Sensitivity for detecting: "+performance(1) +newline + "Specificity: " + performance(2) + newline+"Sensitivity for predicting: " + performance(3);
    elseif NN_name == "NoDelayMLNN"
       target = prepare_data(NN_name,P,T);
       if NoDelayOption == 1
           NN_saved = "ShallowDetect"+dataSet+".mat"; 
       elseif NoDelayOption == 2
           NN_saved = "ShallowPredict"+dataSet+".mat"; 
       end
       [net,performance] = NoDelayMultyLayer(P, target,1,NoDelayOption,0,NN_saved);
       message.Value = "Successful training" + newline+"Sensitivity for detecting: "+performance(1) +newline + "Specificity: " + performance(2) + newline+"Sensitivity for predicting: " + performance(3);
    end       
    

end