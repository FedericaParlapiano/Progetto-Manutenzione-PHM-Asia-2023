clc;
clear all;

dataFolder = 'dataset/train/data/';
files = dir(fullfile(dataFolder, '*.csv'));

data = cell(1, numel(files));
for i = 1:numel(files)
    filePath = fullfile(dataFolder, files(i).name);
    data{i} = readtable(filePath);
end

labelsFile = 'dataset/train/labels.xlsx';
labelsTable = readtable(labelsFile);
labelsTable = renamevars(labelsTable,["Var1","Var2","Var3"],["Case","Spacecraft","Condition"]);
labels = labelsTable.Condition; 


X = data;

% sostituisco le etichette
labels(strcmp(labels, 'Normal')) = {'0'};
labels(strcmp(labels, 'Anomaly')) = {'1'};
labels(strcmp(labels, 'Fault')) = {'1'};
labels = str2double(labels);

% associo a ogni campione l'etichetta abnormal o normal
labeledData = cell(numel(X),2);

for i = 1:numel(X)
    labeledData{i, 1} = X{i};

    % Task5: associo a ogni campione l'etichetta
    if labelsTable{i, "Condition"} == "Normal" || (labelsTable{i,"SV1"}==100 && labelsTable{i,"SV2"}==100 && labelsTable{i,"SV3"}==100 && labelsTable{i,"SV4"}==100)
        labeledData{i, 2} = 'toDrop';
    elseif labelsTable{i,'SV1'}~=100
        labeledData{i,2} = labelsTable{i,'SV1'};
    elseif labelsTable{i,'SV2'}~=100
        labeledData{i,2} = labelsTable{i,'SV2'};
    elseif labelsTable{i,'SV3'}~=100
        labeledData{i,2} = labelsTable{i,'SV3'};
    elseif labelsTable{i,'SV4'}~=100
        labeledData{i,2} = labelsTable{i,'SV4'};
    else
        labeledData{i,2} = 100;
    end

end

labeledData = cell2table(labeledData);
labeledData = renamevars(labeledData,["labeledData1","labeledData2"],["Case","Task5"]);
toDelete = strcmp(labeledData.Task5, "toDrop");
labeledData(toDelete,:) = [];
size(labeledData)
