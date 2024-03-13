%load('54802.mat')
load ('112502.mat')
P = FeatVectSel.';

% Initialize the Trg_vector with all 1
Trg_vector = ones(size(Trg));

% Find the indices of the ictals in order to set the value "3" in such positions of the Trg_vector
ictal_indices = find(Trg == 1);
Trg_vector (ictal_indices) = 3;
%%
new_ictal = find(Trg==1,1); % save the first seizure
end_ictal = [];
for i=1:length(ictal_indices)-1
    if ictal_indices(i+1)-ictal_indices(i)==1 %If we have two consecutive => it is the same seizure so we don't have to save it has a new one. 
        continue;
    elseif ictal_indices(i+1)-ictal_indices(i)~=1 % No consecutives ones
        end_ictal = [end_ictal ictal_indices(i)];
        new_ictal = [new_ictal ictal_indices(i+1)]; % Beginning of each new seizure
    end
end
end_ictal = [end_ictal ictal_indices(length(ictal_indices))];
%%
for i = 1:length(new_ictal)
    % Set preictal points to 2 (300 points before the first 1)
    preictal_start = new_ictal(i) - 300;
    preictal_range = preictal_start:(new_ictal(i)-1);
    Trg_vector(preictal_range)= 2;
    
    % Set postictal phase as ictal (as said in page 3)
    postictal_end =end_ictal(i) + 60;
    postictal_range = postictal_end:(new_ictal(i)-1);
    Trg_vector(new_ictal(i)+1:postictal_end) = 3;
end
%%
% Initialize the T matrix with zeros
T = zeros(3, length(Trg));

% Populate the T matrix with the 3 states (interictal, preictal and ictal)
for i =1:length(Trg_vector)
    switch Trg_vector(i)
        case 1
            T(1,i) = 1; % case interictal -> [1 0 0]
        case 2
            T(2,i) = 1; % case preictal -> [0 1 0]
        case 3
            T(3,i) = 1; % case ictal -> [0 0 1]
    end
end