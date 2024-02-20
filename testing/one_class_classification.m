function [pred] = one_class_classification(trainTable, testTable, numWindow, maggioranza)
    load('classificatori/unknown.mat')
    
    if ismember('Task2', trainTable.Properties.VariableNames)
        trainTable = removevars(trainTable,["Task2"]);
        testTable = removevars(testTable,["Task2"]);
    end
    if ismember('EnsembleID_', trainTable.Properties.VariableNames)
        trainTable = removevars(trainTable,["EnsembleID_"]);
        testTable = removevars(testTable,["EnsembleID_"]);
    end

    % train the model
    [tf_test,s_test] = isanomaly(Mdl,testTable);
    
    pred = []
    for i = 1:numWindow:length(tf_test)-numWindow+1
        anomalies = sum(tf_test(i:i+numWindow-1) == 1);
        if anomalies>=1
            pred = [pred, 1];
        else
            pred = [pred, 0];
        end
    end
end