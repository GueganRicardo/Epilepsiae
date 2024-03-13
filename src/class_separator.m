function [ictal ,preictal ,interictal] = class_separator(P,T)
% For a patient, a number of interictal points at most equal to the sum of the points of the
% other classes should be chosen, for example randomly. This corresponds to an
% undersampling of the interictal phase. 

ictal = [];
preictal = [];
interictal = [];

for i = 1:length(P)
    if max(T(3, i)) == 1
       ictal = [ictal P(:,i)];
    elseif max(T(2, i)) == 1
       preictal = [preictal P(:,i)];
    else 
       interictal = [interictal P(:,i)];
    end
end

end