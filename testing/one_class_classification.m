function [pred] = one_class_classification(testTable, numWindow)
    load('classificatori/unknown.mat')
    
    if ismember('Task2', testTable.Properties.VariableNames)
        testTable = removevars(testTable,["Task2"]);
    end
    if ismember('EnsembleID_', testTable.Properties.VariableNames)
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