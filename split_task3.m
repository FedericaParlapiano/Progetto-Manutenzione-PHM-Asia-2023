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
[numRows,numCols] = size(data{1});
n_step = 3;
step = (numRows-1)/n_step;

header = X{1,1}.Properties.VariableNames;
allVars = 1:width(X{1,1});

j = 0;
for i=1:numel(X)
    split_case{j+1, 1} = X{1,i}{1:step,:};
    split_case{j+1, 1} = array2table(split_case{j+1, 1});
    split_case{j+1, 1} = renamevars(split_case{j+1, 1},allVars,header);

    split_case{j+2, 1} = X{1,i}{step+1:step*2,:};
    split_case{j+2, 1} = array2table(split_case{j+2, 1});
    split_case{j+2, 1} = renamevars(split_case{j+2, 1},allVars,header);
    
    split_case{j+3, 1} = X{1,i}{step*2+1:step*3+1,:};
    split_case{j+3, 1} = array2table(split_case{j+3, 1});
    split_case{j+3, 1} = renamevars(split_case{j+3, 1},allVars,header);

    j = j+n_step;
end

% sostituisco le etichette
labels(strcmp(labels, 'Normal')) = {'0'};
labels(strcmp(labels, 'Anomaly')) = {'1'};
labels(strcmp(labels, 'Fault')) = {'1'};
labels = str2double(labels);

% struttura della tabella che conterrà nella prima colonna il case e nella seconda colonna la label
labeledData = cell(numel(split_case),2);

for j = 1:numel(split_case)
    labeledData{j, 1} = split_case{j};
end

c = 0;
for i = 1:numel(X)  
    % Task3 :associo a ogni campione l'etichetta BV1 o BP1-BP7
    if labelsTable{i, "Condition"} == "Normal" || (labelsTable{i,"BP1"}=="No" && labelsTable{i,"BP2"}=="No" && labelsTable{i,"BP3"}=="No" && labelsTable{i,"BP4"}=="No" && labelsTable{i,"BP5"}=="No" && labelsTable{i,"BP6"}=="No" && labelsTable{i,"BP7"}=="No" && labelsTable{i,"BV1"}=="No")
        labeledData{c+1, 2} = 'toDrop';
        labeledData{c+2, 2} = 'toDrop';
        labeledData{c+3, 2} = 'toDrop';
    elseif labelsTable{i,"BP1"} == "Yes"
        labeledData{c+1,2} = 1;
        labeledData{c+2,2} = 1;
        labeledData{c+3,2} = 1;
    elseif labelsTable{i,"BP2"} == "Yes"
        labeledData{c+1,2} = 2;
        labeledData{c+2,2} = 2;
        labeledData{c+3,2} = 2;
    elseif labelsTable{i,"BP3"} == "Yes"
        labeledData{c+1,2} = 3;
        labeledData{c+2,2} = 3;
        labeledData{c+3,2} = 3;
    elseif labelsTable{i,"BP4"} == "Yes"
        labeledData{c+1,2} = 4;
        labeledData{c+2,2} = 4;
        labeledData{c+3,2} = 4;
    elseif labelsTable{i,"BP5"} == "Yes"
        labeledData{c+1,2} = 5;
        labeledData{c+2,2} = 5;
        labeledData{c+3,2} = 5;
    elseif labelsTable{i,"BP6"} == "Yes"
        labeledData{c+1,2} = 6;
        labeledData{c+2,2} = 6;
        labeledData{c+3,2} = 6;
    elseif labelsTable{i,"BP7"} == "Yes"
        labeledData{c+1,2} = 7;
        labeledData{c+2,2} = 7;
        labeledData{c+3,2} = 7;
    elseif labelsTable{i,"BV1"} == "Yes"
        labeledData{c+1,2} = 8;
        labeledData{c+2,2} = 8;
        labeledData{c+3,2} = 8;
    end  
    c = c+3;
end

labeledData = cell2table(labeledData);
labeledData = renamevars(labeledData,["labeledData1","labeledData2"],["Case","Task3"]);
toDelete = strcmp(labeledData.Task3, "toDrop");
labeledData(toDelete,:) = [];
Case = labeledData.Case;
Task3 = cell2mat(labeledData.Task3);
labeledData = table(Case,Task3);
size(labeledData)
