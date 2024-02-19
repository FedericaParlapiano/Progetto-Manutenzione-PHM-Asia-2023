function [count, prediction] = testing_unlabeled_data(numWindow, trainTable, testTable, trainedModel)

import one_class_classification.*

    
    maggioranza = int32(numWindow/2);
    dueterzi = int32(numWindow*2/3);
    
    feature = trainTable;


    if isempty(trainedModel) == 0
        [yfit,scores]=trainedModel.predictFcn(testTable);
        len = length(yfit);
        
        prediction = [];
    end
    
    if ismember('Task1', trainTable.Properties.VariableNames)
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

        wheels = [count_normal count_abnormal];
        names = ["Class 0" "Class 1"];

        count = dictionary(names,wheels)

    elseif (ismember('Task2', trainTable.Properties.VariableNames) && isempty(trainedModel))
        [prediction] = one_class_classification(trainTable, testTable, numWindow, maggioranza)
    
        wheels = [length(prediction(prediction == 0)) length(prediction(prediction == 1))];
        names = ["Class 0" "Class 1"];
    
        count = dictionary(names,wheels)
 
    elseif ismember('Task2', trainTable.Properties.VariableNames)

    end
end

    
    
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
    

