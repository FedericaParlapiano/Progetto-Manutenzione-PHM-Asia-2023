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
labeledData = cell(numel(X),6);

for i = 1:numel(X)
    labeledData{i, 1} = X{i};
    labeledData{i, 2} = labels(i);

    % Task2: associo a ogni campione l'etichetta bubble, solenoid o unknown
    if labelsTable{i,"SV1"}~=100 || labelsTable{i,"SV2"}~=100 || labelsTable{i,"SV3"}~=100 || labelsTable{i,"SV4"}~=100
        labeledData{i, 3} = 3;
    elseif labelsTable{i,"BP1"}=="Yes" || labelsTable{i,"BP2"}=="Yes" || labelsTable{i,"BP3"}=="Yes" || labelsTable{i,"BP4"}=="Yes" || labelsTable{i,"BP5"}=="Yes" || labelsTable{i,"BP6"}=="Yes" || labelsTable{i,"BP7"}=="Yes" || labelsTable{i,"BV1"}=="Yes"
         labeledData{i, 3} = 2;
    elseif labelsTable{i,"SV1"}==100 && labelsTable{i,"SV2"}==100 && labelsTable{i,"SV3"}==100 || labelsTable{i,"SV4"}==100 && labelsTable{i,"BP1"}=="No" && labelsTable{i,"BP2"}=="No" && labelsTable{i,"BP3"}=="No" && labelsTable{i,"BP4"}=="No" && labelsTable{i,"BP5"}=="No" && labelsTable{i,"BP6"}=="No" && labelsTable{i,"BP7"}=="No" && labelsTable{i,"BV1"}=="No"
         labeledData{i, 3} = 0;
    else 
        labeledData{i, 3} = 1;
    end

    % Task3:associo a ogni campione l'etichetta BV1 o BP1-BP7
    if labelsTable{i,"BP1"} == "Yes"
        labeledData{i,4} = 1;
    elseif labelsTable{i,"BP2"} == "Yes"
        labeledData{i,4} = 2;
    elseif labelsTable{i,"BP3"} == "Yes"
        labeledData{i,4} = 3;
    elseif labelsTable{i,"BP4"} == "Yes"
        labeledData{i,4} = 4;
    elseif labelsTable{i,"BP5"} == "Yes"
        labeledData{i,4} = 5;
    elseif labelsTable{i,"BP6"} == "Yes"
        labeledData{i,4} = 6;
    elseif labelsTable{i,"BP7"} == "Yes"
        labeledData{i,4} = 7;
    elseif labelsTable{i,"BV1"} == "Yes"
        labeledData{i,4} = 8;
    else
        labeledData{i,4} = 0;
    end

    % Task4: associo a ogni campione l'etichetta SV1-SV4 
    if labelsTable{i,'SV1'}~=100
        labeledData{i,5} = 1;
    elseif labelsTable{i,'SV2'}~=100
        labeledData{i,5} = 2;
    elseif labelsTable{i,'SV3'}~=100
        labeledData{i,5} = 3;
    elseif labelsTable{i,'SV4'}~=100
        labeledData{i,5} = 4;
    else
        labeledData{i,5} = 0;
    end

    % Task4: associo a ogni campione l'etichetta
    if labelsTable{i,'SV1'}~=100
        labeledData{i,6} = labelsTable{i,'SV1'};
    elseif labelsTable{i,'SV2'}~=100
        labeledData{i,6} = labelsTable{i,'SV2'};
    elseif labelsTable{i,'SV3'}~=100
        labeledData{i,6} = labelsTable{i,'SV3'};
    elseif labelsTable{i,'SV4'}~=100
        labeledData{i,6} = labelsTable{i,'SV4'};
    else
        labeledData{i,6} = 100;
    end

end

labeledData = cell2table(labeledData);
labeledData = renamevars(labeledData,["labeledData1","labeledData2","labeledData3", "labeledData4", "labeledData5", "labeledData6"],["Case","Task1","Task2","Task3","Task4","Task5"]);

%diagnosticFeatureDesigner(X, labels);