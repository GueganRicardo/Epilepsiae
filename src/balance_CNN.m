function [P, test, PAmount] = balance_CNN(ictal, preictal, interictal)
    P = [];
    test = [];
    numImages = length(ictal(1, 1, 1, :));
    PAmount = floor(numImages * 0.8);
    
    % Training set
    P = cat(4, P, ictal(:, :, :, 1:PAmount));
    P = cat(4, P, preictal(:, :, :, 1:PAmount));
    P = cat(4, P, interictal(:, :, :, 1:PAmount * 2));
    
    % Test set
    test = cat(4, test, ictal(:, :, :, PAmount + 1:end));
    test = cat(4, test, preictal(:, :, :, PAmount + 1:end));
    test = cat(4, test, interictal(:, :, :, PAmount * 2 + 1:end));
end