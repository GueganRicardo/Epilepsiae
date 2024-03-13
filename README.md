# Machine Learning for Epilepsy Seizure Prediction and Detection

## Introduction
This project aims to predict and detect epilepsy seizures using neural networks. We developed both Shallow Networks and Deep Networks (CNN and LSTM) to classify EEG signal features into three classes: Interictal, Preictal, and Ictal.

## DataSet
The dataset includes data from two patients with different epilepsy seizure types. 

## Neural Network Architectures

### Shallow Network
- A simple feedforward network with two hidden layers of fifty and ten neurons each.

### Convolutional Network (CNN)
- A CNN layer that processes 2D images converted from time series features.
- Includes layers such as 2D convolution, swish activation, max-pooling, and classification output.

### Long Short Time Memory Network (LSTM)
- An LSTM layer with 100 hidden units for sequence learning.
- Incorporates a softmax layer and classification output layer.

### Autoencoders
- Reduces the number of features from 29 to a smaller set for neural network efficiency.

## Machine Learning Techniques

### Class Balancing
- Addresses the imbalance in class distribution by creating balanced training and test sets.

### Error Weights
- Assigns higher weights to Ictal and Preictal classes to prioritize their detection.

## Performance Metrics
- Sensitivity and specificity are measured to evaluate the classifier's performance.

## Results
- The LSTM network showed the best performance in terms of sensitivity and specificity.

## Conclusion
The LSTM network is the most effective for seizure prediction and detection, considering its ability to capture temporal information.

## Code
All code used in this project is available in the `ML_Project.zip` file attached to this document.
