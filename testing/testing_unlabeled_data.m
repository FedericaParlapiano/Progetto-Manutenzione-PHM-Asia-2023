function [classes, prediction] = testing_unlabeled_data(numWindow, testTable, trainedModel)

import one_class_classification.*

    
    maggioranza = int32(numWindow/2);
    dueterzi = 8;

    if class(trainedModel) ~= "OneClassSVM"
        [yfit,scores]=trainedModel.predictFcn(testTable);
        len = length(yfit);
        
        prediction = [];
    end
    
    if ismember('Task1', testTable.Properties.VariableNames)
        for i = 1:numWindow:len-numWindow+1
            countOfOnes = sum(yfit(i:i+numWindow-1) == 1);
            countOfZeros = numWindow-countOfOnes;
            if countOfOnes>=dueterzi
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

        classes = dictionary(names,wheels)

    elseif (ismember('Task2', testTable.Properties.VariableNames) && class(trainedModel) == "OneClassSVM")
        [prediction] = one_class_classification(testTable, numWindow)
    
        wheels = [length(prediction(prediction == 0)) length(prediction(prediction == 1))];
        names = ["Class 0" "Class 1"];
    
        classes = dictionary(names,wheels)
 
    elseif ismember('Task2', testTable.Properties.VariableNames)
        [yfit,scores]=trainedModel.predictFcn(testTable);

        for i = 1:numWindow:len-numWindow+1
            countOfTwo = sum(yfit(i:i+numWindow-1) == 2);
            countOfThree = numWindow-countOfTwo;
            if countOfTwo>=dueterzi
                prediction = [prediction, 2];
            else
                prediction = [prediction, 3];
            end
        end
        wheels = [length(prediction(prediction == 2)) length(prediction(prediction == 3))];
        names = ["Class 2" "Class 3"];
    
        classes = dictionary(names,wheels)
    
    elseif ismember('Task3', testTable.Properties.VariableNames)
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
        classes = [];
    
    elseif ismember('Task4', testTable.Properties.VariableNames)
        for i = 1:numWindow:len-numWindow+1
            countOfOnes = sum(yfit(i:i+numWindow-1) == 1);
            countOfTwos = sum(yfit(i:i+numWindow-1) == 2);
            countOfThree = sum(yfit(i:i+numWindow-1) == 3);
            countOfFour = sum(yfit(i:i+numWindow-1) == 4);
            if countOfOnes>=3
                prediction = [prediction, 1];
            elseif countOfTwos>=3
                prediction = [prediction, 2];
            elseif countOfThree>=3
                prediction = [prediction, 3];
            elseif countOfFour>=3
                prediction = [prediction, 4];
            else
                count = [countOfOnes; countOfTwos; countOfThree; countOfFour];
                [M, I] = max(count);
                prediction = [prediction, I];
            end
        end
        classes = [];


    elseif ismember('Task5', testTable.Properties.VariableNames)
        for i = 1:numWindow:len-numWindow+1
            countOfOnes = sum(yfit(i:i+numWindow-1) == 0);
            countOfTwos = sum(yfit(i:i+numWindow-1) == 25);
            countOfThree = sum(yfit(i:i+numWindow-1) == 50);
            countOfFour = sum(yfit(i:i+numWindow-1) == 75);
            if countOfOnes>=dueterzi
                prediction = [prediction, 0];
            elseif countOfTwos>=dueterzi
                prediction = [prediction, 25];
            elseif countOfThree>=dueterzi
                prediction = [prediction, 50];
            elseif countOfFour>=dueterzi
                prediction = [prediction, 75];
            else
                count = [countOfOnes; countOfTwos; countOfThree; countOfFour];
                [M, I] = max(count);
                prediction = [prediction, (I-1)*25];
            end
        end
        classes = [];

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
    

