function [autoEncoder] = EncoderNet(P, numberOfFeatures)
autoEncoder = trainAutoencoder(P, numberOfFeatures,'MaxEpochs',250);%,'L2WeightRegularization', 0.001
end