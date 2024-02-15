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
    
    % Task3 :associo a ogni campione l'etichetta BV1 o BP1-BP7
    if labelsTable{i, "Condition"} == "Normal" || (labelsTable{i,"BP1"}=="No" && labelsTable{i,"BP2"}=="No" && labelsTable{i,"BP3"}=="No" && labelsTable{i,"BP4"}=="No" && labelsTable{i,"BP5"}=="No" && labelsTable{i,"BP6"}=="No" && labelsTable{i,"BP7"}=="No" && labelsTable{i,"BV1"}=="No")
        labeledData{i, 2} = 'toDrop';
    elseif labelsTable{i,"BP1"} == "Yes"
        labeledData{i,2} = 1;
    elseif labelsTable{i,"BP2"} == "Yes"
        labeledData{i,2} = 2;
    elseif labelsTable{i,"BP3"} == "Yes"
        labeledData{i,2} = 3;
    elseif labelsTable{i,"BP4"} == "Yes"
        labeledData{i,2} = 4;
    elseif labelsTable{i,"BP5"} == "Yes"
        labeledData{i,2} = 5;
    elseif labelsTable{i,"BP6"} == "Yes"
        labeledData{i,2} = 6;
    elseif labelsTable{i,"BP7"} == "Yes"
        labeledData{i,2} = 7;
    elseif labelsTable{i,"BV1"} == "Yes"
        labeledData{i,2} = 8;
    end  

end

labeledData = cell2table(labeledData);
labeledData = renamevars(labeledData,["labeledData1","labeledData2"],["Case","Task3"]);
toDelete = strcmp(labeledData.Task3, "toDrop");
labeledData(toDelete,:) = [];
Case = labeledData.Case;
Task3 = cell2mat(labeledData.Task3);
labeledData = table(Case,Task3);
size(labeledData)
