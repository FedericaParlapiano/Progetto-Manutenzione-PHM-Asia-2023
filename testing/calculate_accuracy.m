function [accuracy, C, somma] = calculate_accuracy(actual, predicted, labels, toDelete)
table = [actual predicted];
table(ismember(table(:,1), toDelete),:) = [];
table(ismember(table(:,2), toDelete),:) = [];

correctPredictions = table(:,1) == table(:,2);
accuracy = sum(correctPredictions) / length(table);

C = confusionmat(table(:,1),table(:,2));

somma = sum(correctPredictions)
end

