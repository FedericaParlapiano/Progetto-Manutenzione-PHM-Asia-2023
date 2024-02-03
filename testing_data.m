import one_class_classification_chiara.*
% num windows fame policy 0.064s
%numWindow = 19;
% num windows fame policy 0.128s
numWindow = 10;

maggioranza = int32(numWindow/2)
dueterzi = int32(numWindow*2/3)

feature = FeatureTable1

[yfit,scores]=trainedModel.predictFcn(testTable);
len = length(yfit);

labels = testTable.Task2;
%labels = testTable.Task3;

label_array = [];


for i = 1:numWindow:len-numWindow+1
    label_array = [label_array, labels(i)];
end

prediction = [];

if ismember('Task1', feature.Properties.VariableNames)
    for i = 1:numWindow:len-numWindow+1
        countOfOnes = sum(yfit(i:i+numWindow-1) == 1);
        countOfZeros = numWindow-countOfOnes;
        if countOfOnes>=maggioranza
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

elseif ismember('Task2', feature.Properties.VariableNames)
    [notUnknownMembers, unknownMembers, indexToRemove] = one_class_classification_chiara(trainTable, testTable, noiseData, numWindow, maggioranza)
    
    [yfit,scores]=trainedModel.predictFcn(notUnknownMembers);

    for i = 1:numWindow:len-numWindow+1
        countOfTwo = sum(yfit(i:i+numWindow-1) == 2);
        countOfThree = numWindow-countOfTwo;
        if countOfTwo>=maggioranza
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
  
elseif ismember('Task3', feature.Properties.VariableNames)
    for i = 1:numWindow:len-numWindow+1
        countOfOnes = sum(yfit(i:i+numWindow-1) == 1);
        countOfTwos = sum(yfit(i:i+numWindow-1) == 2);
        countOfThree = sum(yfit(i:i+numWindow-1) == 3);
        countOfFour = sum(yfit(i:i+numWindow-1) == 4);
        countOfFive = sum(yfit(i:i+numWindow-1) == 5);
        countOfSix = sum(yfit(i:i+numWindow-1) == 6);
        countOfSeven = sum(yfit(i:i+numWindow-1) == 7);
        countOfEight = sum(yfit(i:i+numWindow-1) == 8);
        if countOfOnes>=dueterzi
            prediction = [prediction, 1];
        elseif countOfTwos>=dueterzi
            prediction = [prediction, 2];
        elseif countOfThree>=dueterzi
            prediction = [prediction, 3];
        elseif countOfFour>=dueterzi
            prediction = [prediction, 4];
        elseif countOfFive>=dueterzi
            prediction = [prediction, 5];
        elseif countOfSix>=dueterzi
            prediction = [prediction, 6];
        elseif countOfSeven>=dueterzi
            prediction = [prediction, 7];
        elseif countOfEight>=dueterzi
            prediction = [prediction, 8];
        else
            count = [countOfOnes; countOfTwos; countOfThree; countOfFour; countOfFive; countOfSix; countOfSeven; countOfEight];
            [M, I] = max(count);
            prediction = [prediction, I];

        end
    end

    correctPredictions = label_array == prediction;
    
    % Calculate accuracy
    accuracy = sum(correctPredictions) / numel(label_array);
    
    % Display accuracy
    disp(['Accuracy: ', num2str(accuracy * 100), '%']);
    
    classLabels = {'BP1', 'BP2', 'BP3', 'BP4', 'BP5', 'BP6', 'BP7', 'BV1'};
    
    C = confusionmat(label_array,prediction)
    confusionchart(C,classLabels)
 
end
