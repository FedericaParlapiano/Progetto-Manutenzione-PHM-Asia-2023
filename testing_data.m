numWindow = 10;
[yfit,scores]=trainedModel.predictFcn(testTable);
len = length(yfit);

labels = testTable.Task2;
label_array = [];

for i = 1:numWindow:len-numWindow+1
    label_array = [label_array, labels(i)];
end

prediction = [];

if ismember('Task1', FeatureTable1.Properties.VariableNames)
    
    for i = 1:numWindow:len-numWindow+1
        countOfOnes = sum(yfit(i:i+numWindow-1) == 1);
        countOfZeros = numWindow-countOfOnes;
        if countOfOnes>=10
            prediction = [prediction, 1];
        else
            prediction = [prediction, 0];
        end
    end
    
    
    correctPredictions = label_array == prediction;
    
    % Calculate accuracy
    accuracy = sum(correctPredictions) / numel(label_array);
    
    % Display accuracy
    disp(['Accuracy: ', num2str(accuracy * 100), '%']);
    
    classLabels = {'Normal', 'Abnormal'};
    
    C = confusionmat(label_array,prediction);
    confusionchart(C, classLabels)

elseif ismember('Task2', FeatureTable1.Properties.VariableNames)
    for i = 1:numWindow:len-numWindow+1
        countOfTwo = sum(yfit(i:i+numWindow-1) == 2);
        countOfThree = numWindow-countOfTwo;
        if countOfTwo>=10
            prediction = [prediction, 2];
        else
            prediction = [prediction, 3];
        end
    end
    
    
    correctPredictions = label_array == prediction;
    
    % Calculate accuracy
    accuracy = sum(correctPredictions) / numel(label_array);
    
    % Display accuracy
    disp(['Accuracy: ', num2str(accuracy * 100), '%']);
    
    classLabels = {'Solenoid Valve Fault', 'Bubble Anomaly'}
    
    C = confusionmat(label_array,prediction)
    confusionchart(C, classLabels)
end
    
