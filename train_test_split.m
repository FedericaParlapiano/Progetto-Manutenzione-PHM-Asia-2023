testPercentage = 20;

% num windows fame policy 0.064s
% numWindow = 19;
% num windows fame policy 0.128s
% numWindow = 10;
% num windows fame policy 0.128s split case
numWindow = 4;
% num windows fame policy 0.064s split case
numWindow = 7;

n_step = 3;

features = FeatureTable1;
trainTable = FeatureTable1;


if ismember('Task1', features.Properties.VariableNames)
    % stratified splitting 80-20
    % fino a 105 normal, da 106 a 153 fault, da 154 a 177 anomaly
    normalTestPercentage = int32(105*testPercentage/100);
    faultTestPercentage = int32((153-105)*testPercentage/100);
    anomalyTestPercentage = int32((177-153)*testPercentage/100);
    
    anomalyTest = trainTable(153*numWindow+1:(anomalyTestPercentage+153)*numWindow,:);
    trainTable(153*numWindow+1:(anomalyTestPercentage+153)*numWindow,:) = [];
    
    faultTest = trainTable(105*numWindow+1:(faultTestPercentage+105)*numWindow,:);
    trainTable(105*numWindow+1:(faultTestPercentage+105)*numWindow,:) = [];
    
    normalTest = trainTable(1:normalTestPercentage*numWindow,:);
    trainTable(1:normalTestPercentage*numWindow,:) = [];
    
    testTable = [normalTest; faultTest; anomalyTest];

elseif ismember('Task2', features.Properties.VariableNames)
    % stratified splitting 80-20
    faultTestPercentage = int32(48*testPercentage/100);
    anomalyTestPercentage = int32(24*testPercentage/100);
    
    anomalyTest = trainTable(48*numWindow+1:(anomalyTestPercentage+48)*numWindow,:);
    trainTable(48*numWindow+1:(anomalyTestPercentage+48)*numWindow,:) = [];
    
    faultTest = trainTable(1:faultTestPercentage*numWindow,:);
    trainTable(1:faultTestPercentage*numWindow,:) = [];
    
    testTable = [faultTest; anomalyTest];
   
elseif ismember('Task3', features.Properties.VariableNames)

    n_class=8;
    groups = findgroups(features.Task3);

    idx_1 = find(groups == 1);
    idx_2 = find(groups == 2);
    idx_3 = find(groups == 3);
    idx_4 = find(groups == 4);
    idx_5 = find(groups == 5);
    idx_6 = find(groups == 6);    
    idx_7 = find(groups == 7);
    idx_8 = find(groups == 8);
  
    subset_1 = features(idx_1,:);
    subset_2 = features(idx_2,:);
    subset_3 = features(idx_3,:);
    subset_4 = features(idx_4,:);
    subset_5 = features(idx_5,:);
    subset_6 = features(idx_6,:);
    subset_7 = features(idx_7,:);
    subset_8 = features(idx_8,:);

    testTable = [];
    subsets = {subset_1, subset_2, subset_3, subset_4, subset_5, subset_6, subset_7, subset_8};

    for i=1:n_class
        n = randperm(n_class+1);
        n = n(1:n_step)-1;
        for j=1:length(n)
            r = n(j)*numWindow+1;
            subset = subsets(1,i);
            subset = subset{1,1};
            testTable = [testTable; subset(r:r+numWindow-1, :)];
        end
    end

    indici_da_eliminare = ismember(features.EnsembleID_, testTable.EnsembleID_);
    trainTable = features;
    trainTable(indici_da_eliminare, :) = [];

elseif ismember('Task4', features.Properties.VariableNames)
   
    n_class = 4;
    subset_sv1 = features(features.Task4 == 1, :);   
    subset_sv2 = features(features.Task4 == 2, :);
    subset_sv3 = features(features.Task4 == 3, :);
    subset_sv4 = features(features.Task4 == 4, :);

    testTable = [];
    subsets = {subset_sv1, subset_sv2, subset_sv3, subset_sv4};

    for i=1:n_class
        n = randperm(n_class*2+1);
        n = n(1:n_step*2)-1;
        for j=1:length(n)
            r = n(j)*numWindow+1;
            subset = subsets(1,i);
            subset = subset{1,1};
            testTable = [testTable; subset(r:r+numWindow-1, :)];
        end
    end

    indici_da_eliminare = ismember(features.EnsembleID_, testTable.EnsembleID_);
    trainTable = features;
    trainTable(indici_da_eliminare, :) = [];

 elseif ismember('Task5', features.Properties.VariableNames)

    n_class = 4;
    subset_1 = features(features.Task5 == 25, :);   
    subset_2 = features(features.Task5 == 50, :);
    subset_3 = features(features.Task5 == 75, :);
    subset_4 = features(features.Task5 == 0, :);

    testTable = [];
    subsets = {subset_1, subset_2, subset_3, subset_4};

    for i=1:n_class
        n = randperm(n_class*2+1);
        n = n(1:n_step*2)-1;
        for j=1:length(n)
            r = n(j)*numWindow+1;
            subset = subsets(1,i);
            subset = subset{1,1};
            testTable = [testTable; subset(r:r+numWindow-1, :)];
        end
    end

    indici_da_eliminare = ismember(features.EnsembleID_, testTable.EnsembleID_);
    trainTable = features;
    trainTable(indici_da_eliminare, :) = [];

end