function train_and_test(NN_name,autoEncoder,number_of_features,class_balancing,error_weigths,NoDelayOption,dataSet,message)
   try  
        path = dataSet+".mat";
        disp(path)
        load(path);
         P = FeatVectSel.';
         T= Trg;
    catch ME
        message.Value = "Dataset should be on the project folder";
        message.Visible = "on";
        return;
    end
    
    if autoEncoder
       encoderName = "autoEncoder"+ number_of_features+ "_"+dataSet+".mat";
       display(encoderName)
      try
        encoder = load(encoderName);
        P = encode(encoder,P);
      catch ME
          message.Value = "Encoder dont not exits!";
          return;
      end

    end

    if NN_name == "CNN"
        target = prepare_data(NN_name,P,T);
        [net,performance] = ConvolutionalNeuralNetwork(P,target,10,class_balancing,error_weigths,1,"Without");
        message.Value = "Successful training" + newline+"Sensitivity for detecting: "+performance(1) +newline + "Specificity: " + performance(2) + newline+"Sensitivity for predicting: " + performance(3);
    elseif NN_name == "LSTM"
       [~,target] = prepare_data(NN_name,P,T); 
       [net,performance] = LongShortTermMemory(P, target,error_weigths,class_balancing,1,"Without");
       message.Value = "Successful training" + newline+"Sensitivity for detecting: "+performance(1) +newline + "Specificity: " + performance(2) + newline+"Sensitivity for predicting: " + performance(3);
    elseif NN_name == "NoDelayMLNN"
       target = prepare_data(NN_name,P,T);
       [net,performance] = NoDelayMultyLayer(P, target,class_balancing,NoDelayOption,1,"Without");
       message.Value = "Successful training" + newline+"Sensitivity for detecting: "+performance(1) +newline + "Specificity: " + performance(2) + newline+"Sensitivity for predicting: " + performance(3);
    end       
end