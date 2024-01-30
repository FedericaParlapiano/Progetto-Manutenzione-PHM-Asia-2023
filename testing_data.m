numWindow = 19;

[yfit,scores]=trainedModel2.predictFcn(testTable);

len = length(yfit);

labels = testTable.Task1;
label_array = [];

for i = 1:numWindow:len-numWindow+1
    label_array = [label_array, labels(i)];
end

prediction = [];

for i = 1:numWindow:len-numWindow+1
    countOfOnes = sum(yfit(i:i+numWindow-1) == 1);
    countOfZeros = numWindow-countOfOnes;
    if countOfOnes>=5
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






