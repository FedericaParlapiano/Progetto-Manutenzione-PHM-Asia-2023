function [labeledData] = task1(dataFolder, labelsFile)

    files = dir(fullfile(dataFolder, '*.csv'));
    
    data = cell(1, numel(files));
    for i = 1:numel(files)
        filePath = fullfile(dataFolder, files(i).name);
        data{i} = readtable(filePath);
    end
    
    if labelsFile~=""
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
            labeledData{i, 2} = labels(i);
        end
        
        labeledData = cell2table(labeledData);
        labeledData = renamevars(labeledData,["labeledData1","labeledData2"],["Case","Task1"]);

    else

        labeledData = cell2table(data');
        labeledData = renamevars(labeledData,["Var1"],["Case"]);
        
    end
end
