import one_class_classification.*
% num windows frame policy 0.064s
numWindow = 10;
% num windows frame policy 0.128s
% numWindow = 10;

maggioranza = int32(numWindow/2)+1;
dueterzi = int32(numWindow*2/3)+1;

feature = trainTable;
testTable = testTable;
% trainTable = FeatureTableTrain;


% [yfit,scores]=trainedModel1.predictFcn(testTable);
yfit=trainedModel1.predictFcn(testTable);
len = length(yfit);

labels = testTable.Task5;
%labels = testTable.Task3;
%labels = testTable.Task5;
%labels = testTable.Task4;

label_array = [];


for i = 1:numWindow:len-numWindow+1
    label_array = [label_array, labels(i)];
end

prediction = [];

if ismember('Task1', feature.Properties.VariableNames)
    for i = 1:numWindow:len-numWindow+1
        countOfOnes = sum(yfit(i:i+numWindow-1) == 1);
        countOfZeros = numWindow-countOfOnes;
        if countOfOnes>=dueterzi
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
    [notUnknownMembers, unknownMembers, indexToRemove] = one_class_classification(trainTable, testTable, numWindow, maggioranza)
 
    [yfit,scores]=trainedModel1.predictFcn(notUnknownMembers);

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
        count = [countOfOnes; countOfTwos; countOfThree; countOfFour; countOfFive; countOfSix; countOfSeven; countOfEight];
        [M, I] = max(count);
        prediction = [prediction, I];

    end

    correctPredictions = label_array == prediction;
    
    % Calculate accuracy
    accuracy = sum(correctPredictions) / numel(label_array);
    
    % Display accuracy
    disp(['Accuracy: ', num2str(accuracy * 100), '%']);
    
    classLabels = {'BP1', 'BP2', 'BP3', 'BP4', 'BP5', 'BP6', 'BP7', 'BV1'};
    
    C = confusionmat(label_array,prediction)
    confusionchart(C,classLabels)

elseif ismember('Task4', feature.Properties.VariableNames)
    for i = 1:numWindow:len-numWindow+1
        countOfOnes = sum(yfit(i:i+numWindow-1) == 1);
        countOfTwos = sum(yfit(i:i+numWindow-1) == 2);
        countOfThree = sum(yfit(i:i+numWindow-1) == 3);
        countOfFour = sum(yfit(i:i+numWindow-1) == 4);
        count = [countOfOnes; countOfTwos; countOfThree; countOfFour];
        [M, I] = max(count);
        prediction = [prediction, I];

    end

    correctPredictions = label_array == prediction;
    
    % Calculate accuracy
    accuracy = sum(correctPredictions) / numel(label_array);
    
    % Display accuracy
    disp(['Accuracy: ', num2str(accuracy * 100), '%']);
    
    classLabels = {'SV1', 'SV2', 'SV3', 'SV4'};
    
    C = confusionmat(label_array,prediction)
    confusionchart(C,classLabels)

elseif ismember('Task5classification', feature.Properties.VariableNames)
    for i = 1:numWindow:len-numWindow+1
        countOfOnes = sum(yfit(i:i+numWindow-1) == 0);
        countOfTwos = sum(yfit(i:i+numWindow-1) == 25);
        countOfThree = sum(yfit(i:i+numWindow-1) == 50);
        countOfFour = sum(yfit(i:i+numWindow-1) == 75);
        count = [countOfOnes; countOfTwos; countOfThree; countOfFour];
        [M, I] = max(count);
        prediction = [prediction, (I-1)*25];
    end

    correctPredictions = label_array == prediction;
    
    % Calculate accuracy
    accuracy = sum(correctPredictions) / numel(label_array);
    
    % Display accuracy
    disp(['Accuracy: ', num2str(accuracy * 100), '%']);
    
    classLabels = {'0', '25', '50', '75'};
    
    C = confusionmat(label_array,prediction)
    confusionchart(C,classLabels)

elseif ismember('Task5', feature.Properties.VariableNames)  
    
    for i = 1:numWindow:len-numWindow+1
        % prediction_mean = [];
        prediction_median = [];
        for j = i:i+numWindow-1
            % prediction_mean = [prediction_mean, yfit(j)];
            prediction_median = [prediction_median, yfit(j)];
        end
        % prediction = [prediction, mean(prediction_mean)];
        prediction = [prediction, median(prediction_median)];
    end
    
    % RMSE_mean = rmse(label_array, prediction);
    RMSE_median = rmse(label_array, prediction);

    % disp(['RMSE_mean: ', num2str(RMSE_mean)]);
    disp(['RMSE_median: ', num2str(RMSE_median)]);
    
    error = prediction-label_array;
    MAE = mae(error);
    disp(['MAE: ', num2str(MAE)]);

    samples = [1:length(prediction)];
    scatter(samples, prediction, 50, 'red','filled');
    hold on;
    scatter(samples, label_array, 50, 'green','filled');
    hold on;
    xlabel('sample')
    ylabel('opening ratio')
    legend('predicted', 'true')
    xlabel('sample')
    title(['Scatter plot']);
    subtitle(['RMSE: ', num2str(RMSE_median), newline, 'MAE: ', num2str(MAE)])
end