import one_class_classification_chiara.*

data = labeledData;

% num windows frame policy 0.064s
% numWindow = 19;
% num windows frame policy 0.128s
numWindow = 10;

maggioranza = int32(numWindow/2);
dueterzi = int32(numWindow*2/3);

feature = FeatureTable1;
% noiseData = FeatureTable1(721:820,:);

[yfit,scores]=trainedModel.predictFcn(testTable);
len = length(yfit);

classification = true;

labels = testTable.Task1;
%labels = testTable.Task2;
%labels = testTable.Task3;
%labels = testTable.Task5;

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

    count_normal = length(prediction(prediction == 0));   
    count_abnormal = length(prediction(prediction == 1));

    fprintf('Data classified as normal (class 0): %d \n', count_normal);
    fprintf('Data classified as abnormal (class 1): %d \n', count_abnormal);

    % % PCA dati
    % [coeff,score,latent,~,explained] = pca(data.Case{:,1});
    % 
    % % selezione delle prime due componenti principali
    % score = score(:,1:2);
    % 
    % % feature da utilizzare per il colore dei punti nel plot
    % feature_da_colore = data(:,1);
    % 
    % % plot dei dati
    % scatter(score(:,1), score(:,2), 50, feature_da_colore, 'filled');
    % colorbar; % barra dei colori
    % xlabel('Componente Principale 1');
    % ylabel('Componente Principale 2');
    % title('Plot dei dati dopo PCA');

end