import testing_unlabeled_data.*
import generate_function_task1.*
import generate_function_task2.*
import generate_function_task2_unknown.*
import generate_function_task3.*
import generate_function_task4.*
import generate_function_task5.*

import plot_data.*

import calculate_accuracy.*
import task1.*
load('classificatori/trainedModel1.mat')
load('classificatori/unknown.mat')
load('classificatori/trainedModel2.mat')
load('classificatori/trainedModel3.mat')
load('classificatori/trainedModel4.mat')
load('classificatori/trainedModel5.mat')
load('regressori/trainedModel5regressione.mat')



trainPath = '../dataset/train/data/';
labelsPath = '../dataset/train/labels.xlsx';
testPath = '../dataset/test/data/';
answers = 'answer.csv';
answers = readtable(answers, 'VariableNamingRule', 'preserve');


%% task 1, normal & abnormal data
[testDataTask1] = task1(testPath, "");
[testFeatureTable1, x] = generate_function_task1(testDataTask1);

[count1, prediction1] = testing_unlabeled_data(10, testFeatureTable1, trainedModel1, false);
fprintf('Data classified as normal (class 0): %d \n', count1("Class 0"));
fprintf('Data classified as abnormal (class 1): %d \n', count1("Class 1"));

task1Actual = answers.task1';
correctPredictions = task1Actual == prediction1;

% Calculate accuracy
accuracy = sum(correctPredictions) / numel(task1Actual);

% Display accuracy
disp(['Accuracy: ', num2str(accuracy * 100), '%']);

classLabels = {'Normal', 'Abnormal'};

C = confusionmat(task1Actual,prediction1);

figure;
confusionchart(C, classLabels);
sgtitle(['Total Accuracy: ', num2str(accuracy * 100), ' %']);

fig_name = 'image/confusionchart_task1';
set(gcf, 'Position', [150, 150, 600, 500])
saveas(gcf, strcat(fig_name, '.png'));

prediction1 = [answers.ID prediction1'];


plot_data(testFeatureTable1, prediction1(:,2), 1, '');
confronti = (prediction1(:,2)==task1Actual');
plot_data(testFeatureTable1, confronti, 1, 'actual');


%% task 2, unknown data
idx = prediction1(:,2)==1;
testDataTask2 = [testDataTask1(prediction1(:,2)==1,:) table(prediction1(idx,1))];

[testFeatureTable2Unknown] = generate_function_task2_unknown(testDataTask2(:,1));

[count2Unknown, prediction2Unknown] = testing_unlabeled_data(10, testFeatureTable2Unknown, Mdl, false);
fprintf('Data classified as not unknown (class 0): %d \n', count2Unknown("Class 0"));
fprintf('Data classified as unknown (class 1): %d \n', count2Unknown("Class 1"));


testDataTask2 = renamevars(testDataTask2,["Var1"],["ID"]);
prediction2Unknown = [testDataTask2(:,2) table(prediction2Unknown')];

task2ActualUnknown = array2table([answers.ID, answers.task2]);
task2ActualUnknown = renamevars(task2ActualUnknown,["Var1", "Var2"],["ID", "Task2"]);
[commonIDs, ~, ~] = intersect(task2ActualUnknown.ID, prediction2Unknown.ID);

task2ActualUnknown(~(ismember(task2ActualUnknown.ID, commonIDs)), :) = [];
idx = find(task2ActualUnknown.Task2 ~= 1);
task2ActualUnknown.Task2(idx) = 0;

plot_data(testFeatureTable2Unknown, prediction2Unknown.Var1, 'unknown', '');
confronti = (task2ActualUnknown.Task2==prediction2Unknown.Var1);
plot_data(testFeatureTable2Unknown, confronti, 'unknown', 'actual');


%% task 2, bubble, valve
idx = table2array(prediction2Unknown(:,2))==0;
testDataTask2 = [testDataTask2(idx,1) prediction2Unknown(idx,1)];
[testFeatureTable2] = generate_function_task2(testDataTask2(:,1));
[count2, prediction2] = testing_unlabeled_data(10, testFeatureTable2, trainedModel2, false);
fprintf('Data classified as bubble anomaly (class 2): %d \n', count2("Class 2"));
fprintf('Data classified as valve fault (class 3): %d \n', count2("Class 3"));

prediction2 = [testDataTask2(:,2) table(prediction2')];
prediction1 = array2table(prediction1);
prediction1 = renamevars(prediction1,["prediction11", "prediction12"],["ID", "Var1"]);

task2Prediction = prediction1;

[commonIDs, locTable1, locTable2] = intersect(task2Prediction.ID, prediction2.ID);
task2Prediction.Var1(locTable1) = prediction2.Var1(locTable2);

task2Actual = answers.task2';

correctPredictions = task2Actual' == task2Prediction.Var1;

% Calculate accuracy
accuracy2 = sum(correctPredictions) / numel(task2Actual);

% Display accuracy
disp(['Accuracy: ', num2str(accuracy2 * 100), '%']);

classLabels2 = {'Normal', 'Unknown', 'Bubble Anomaly', 'Valve'};

C2 = confusionmat(task2Actual,task2Prediction.Var1);

[accuracyTask2, confusionMatrixTask2, somma2, table2] = calculate_accuracy(task2Actual', task2Prediction.Var1, {'Unknown', 'Bubble Anomaly', 'Valve'}, 0);

figure;
subplot(1, 2, 1);
confusionchart(C2, classLabels2);
title(['Confusion Matrix Submission Format: ', num2str(accuracy2*100), ' %']);

% Create the second confusion matrix chart
subplot(1, 2, 2);
confusionchart(confusionMatrixTask2, {'Unknown', 'Bubble Anomaly', 'Valve'});
title(['Confusion Matrix Task 2: ', num2str(accuracyTask2*100), ' %']);

sgtitle(['Total Accuracy: ', num2str((somma2/height(prediction2Unknown))*100), ' %']);

fig_name = 'image/confusionchart_task2';
set(gcf, 'Position', [150, 150, 1000, 500])
saveas(gcf, strcat(fig_name, '.png'));



plot_data(testFeatureTable2, prediction2.Var1, 2, '');
actual2 = array2table(table2);
actual2 = actual2(actual2.table21~=1, :);
confronti = (actual2.table21==actual2.table22);
plot_data(testFeatureTable2, confronti, 2, 'actual');



%% task 3, bubble
testDataTask3 = testDataTask2(prediction2.Var1 == 2, :);
[testFeatureTable3] = generate_function_task3(testDataTask3(:,1));
[count3, prediction3] = testing_unlabeled_data(10, testFeatureTable3, trainedModel3, false);
prediction3 = [testDataTask3(:,2) table(prediction3')];
index = prediction1;
index(:,2) = {0};
task3Prediction = index;
[commonIDs, locTable1, locTable2] = intersect(task3Prediction.ID, prediction3.ID);
task3Prediction.Var1(locTable1) = prediction3.Var1(locTable2);

task3Actual = answers.task3';

correctPredictions = task3Actual' == task3Prediction.Var1;

% Calculate accuracy
accuracy3 = sum(correctPredictions) / numel(task3Actual);

% Display accuracy
disp(['Accuracy: ', num2str(accuracy3 * 100), '%']);

classLabels3 = {'Other', 'BP1', 'BP2', 'BP3', 'BP4', 'BP5', 'BP6', 'BP7'};
C3 = confusionmat(task3Actual,task3Prediction.Var1);

[accuracyTask3, confusionMatrixTask3, somma3, table3] = calculate_accuracy(task3Actual', task3Prediction.Var1, {'BP1', 'BP2', 'BP3', 'BP4', 'BP5', 'BP6', 'BP7'}, 0);

figure;
subplot(1, 2, 1);
confusionchart(C3, classLabels3);
title(['Confusion Matrix Submission Format: ', num2str(accuracy3*100), ' %']);

% Create the second confusion matrix chart
subplot(1, 2, 2);
confusionchart(confusionMatrixTask3, {'BP1', 'BP2', 'BP3', 'BP4', 'BP5', 'BP6', 'BP7'});
title(['Confusion Matrix Task 3: ', num2str(accuracyTask3*100), ' %']);

sgtitle(['Total Accuracy: ', num2str(somma3/(height(prediction3))*100), ' %']);

fig_name = 'image/confusionchart_task3';
set(gcf, 'Position', [150, 150, 1000, 500])
saveas(gcf, strcat(fig_name, '.png'));

plot_data(testFeatureTable3, prediction3.Var1, 3, '');

actual3 = array2table(table3);
confronti = (actual3.table31==actual3.table32);
plot_data(testFeatureTable3,  confronti, 3, 'actual');

%% task 4, valve
testDataTask45 = testDataTask2(prediction2.Var1 == 3, :);
[testFeatureTable4] = generate_function_task4(testDataTask45);
[count4, prediction4] = testing_unlabeled_data(5, testFeatureTable4, trainedModel4, false);
prediction4 = [testDataTask45(:,2) table(prediction4')];
task4Prediction = index;
[commonIDs, locTable1, locTable2] = intersect(task4Prediction.ID, prediction4.ID);
task4Prediction.Var1(locTable1) = prediction4.Var1(locTable2);
task4Actual = answers.task4';
correctPredictions = task4Actual' == task4Prediction.Var1;

accuracy4 = sum(correctPredictions) / numel(task4Actual);
disp(['Accuracy: ', num2str(accuracy4 * 100), '%']);
classLabels4 = {'Other', 'SV1', 'SV2', 'SV3', 'SV4'};
C4 = confusionmat(task4Actual,task4Prediction.Var1);


[accuracyTask4, confusionMatrixTask4, somma4, table4] = calculate_accuracy(task4Actual', task4Prediction.Var1, {'SV1', 'SV2', 'SV3', 'SV4'}, 0);

figure;
subplot(1, 2, 1);
confusionchart(C4, classLabels4)
title(['Confusion Matrix Submission Format: ', num2str(accuracy4*100), ' %']);

% Create the second confusion matrix chart
subplot(1, 2, 2);
confusionchart(confusionMatrixTask4, {'SV1', 'SV2', 'SV3', 'SV4'});
title(['Confusion Matrix Task 4: ', num2str(accuracyTask4*100), ' %']);

sgtitle(['Total Accuracy: ', num2str(somma4/(height(prediction4))*100), ' %']);

fig_name = 'image/confusionchart_task4';
set(gcf, 'Position', [150, 150, 1000, 500])
saveas(gcf, strcat(fig_name, '.png'));


plot_data(testFeatureTable4, prediction4.Var1, 4, '');
actual4 = array2table(table4);
confronti = (actual4.table41==actual4.table42);
plot_data(testFeatureTable4,  confronti, 4, 'actual');


%% task 5, valve opening ratio classification
[testFeatureTable5] = generate_function_task5(testDataTask45(:,1));
[count5, prediction5] = testing_unlabeled_data(10, testFeatureTable5, trainedModel5, false);
prediction5 = [testDataTask45(:,2) table(prediction5')];
index(:,2) = {100};
task5Prediction = index;
[commonIDs, locTable1, locTable2] = intersect(task5Prediction.ID, prediction5.ID);
task5Prediction.Var1(locTable1) = prediction5.Var1(locTable2);
task5Actual = answers.task5';


for i = 1:length(task5Actual)
    if task5Actual(1,i)~=100
        remainder = mod(task5Actual(1,i), 25);
        if remainder <= 12
            roundingOffset = -remainder;
        else
            roundingOffset = 25 - remainder;
        end
        task5Actual(1,i) = task5Actual(1,i) + roundingOffset;
        task5Actual(1,i) = max(0, min(task5Actual(1,i), 75));
    end
end

correctPredictions = task5Actual' == task5Prediction.Var1;

accuracy5 = sum(correctPredictions) / numel(task5Actual);
disp(['Accuracy: ', num2str(accuracy5 * 100), '%']);
classLabels5 = {'0', '25', '50', '75', '100'};
C5 = confusionmat(task5Actual,task5Prediction.Var1);

[accuracyTask5, confusionMatrixTask5, somma5, table5] = calculate_accuracy(task5Actual', task5Prediction.Var1, {'0', '25', '50', '75'}, 100);

figure;
subplot(1, 2, 1);
confusionchart(C5, classLabels5);
title(['Confusion Matrix Submission Format: ', num2str(accuracy5*100), ' %']);

% Create the second confusion matrix chart
subplot(1, 2, 2);
confusionchart(confusionMatrixTask5, {'0', '25', '50', '75'});
title(['Confusion Matrix Task 5: ', num2str(accuracyTask5*100), ' %']);

sgtitle(['Total Accuracy: ', num2str(somma5/(height(prediction5))*100), ' %']);

fig_name = 'image/confusionchart_task5';
set(gcf, 'Position', [150, 150, 1000, 500])
saveas(gcf, strcat(fig_name, '.png'));

plot_data(testFeatureTable5, prediction5.Var1, 5,'');
actual5 = array2table(table5);
confronti = (actual5.table51==actual5.table52);
plot_data(testFeatureTable5, confronti, 5,'actual');


%% task 5, valve opening ratio regression
[testFeatureTable5r] = generate_function_task5_regressione13feature(testDataTask45(:,1));
[count5r, prediction5r] = testing_unlabeled_data(10, testFeatureTable5r, trainedModel5regression13feature, true);
prediction5r = [testDataTask45(:,2) table(prediction5r')];
index(:,2) = {100};
task5Predictionr = index;
[commonIDs, locTable1, locTable2] = intersect(task5Predictionr.ID, prediction5r.ID);
task5Predictionr.Var1(locTable1) = prediction5r.Var1(locTable2);
task5Actualr = answers.task5';

for i = 1:length(task5Actualr)
     if task5Actualr(1,i)~=100
         remainder = mod(task5Actualr(1,i), 25);
         if remainder <= 12
             roundingOffset = -remainder;
         else
             roundingOffset = 25 - remainder;
         end
         task5Actualr(1,i) = task5Actualr(1,i) + roundingOffset;
         task5Actualr(1,i) = max(0, min(task5Actualr(1,i), 75));
     end
 end

% RMSE_mean = rmse(label_array, prediction);
RMSE_median = rmse(answers.task5(locTable1), prediction5r.Var1(locTable2));

% disp(['RMSE_mean: ', num2str(RMSE_mean)]);
disp(['RMSE_median: ', num2str(RMSE_median)]);

error = answers.task5(locTable1) - prediction5r.Var1(locTable2);
MAE = mae(error);
disp(['MAE: ', num2str(MAE)]);

figure;
samples = [1:length(prediction5r.Var1(locTable2))];
scatter(samples, prediction5r.Var1(locTable2), 50, 'red','filled');
hold on;
scatter(samples, (answers.task5(locTable1))', 50, 'green','filled');
hold on;
xlabel('sample')
ylabel('opening ratio')
legend('predicted', 'true')
title(['Scatter plot Task 5']);
subtitle(['RMSE: ', num2str(RMSE_median), newline, 'MAE: ', num2str(MAE)])

%% final score

[score]  = calculate_score(answers, prediction1, task2Prediction, task3Prediction, task4Prediction, task5Predictionr);
disp(['Score finale: ', num2str(score,'%.2f'),'%']);
