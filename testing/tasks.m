import testing_unlabeled_data.*
import generate_feature_task1.*
import task1.*
load('classificatori/trainedModel1.mat')


trainPath = '../dataset/train/data/';
labelsPath = '../dataset/train/labels.xlsx';
testPath = '../dataset/test/data/';


% task 1
[trainDataTask1] = task1(trainPath, labelsPath);
[trainFeatureTable1, x] = generate_feature_task1(trainDataTask1);
[testDataTask1] = task1(testPath, "");
[testFeatureTable1, x] = generate_feature_task1(testDataTask1);

% frame policy = 128
[count1, prediction1] = testing_unlabeled_data(10, trainFeatureTable1, testFeatureTable1, trainedModel1);
fprintf('Data classified as normal (class 0): %d \n', count1("Class 0"));
fprintf('Data classified as abnormal (class 1): %d \n', count1("Class 1"));


% task 2, unknown data
[trainDataTask2] = task2(trainPath, labelsPath);
trainDataTask2{:, 2} = 0;
[trainFeatureTable2Unknown] = generate_function_task2_unknown(trainDataTask2);
testDataTask2 = testDataTask1(prediction1' == 1, :);
[testFeatureTable2Unknown] = generate_function_task2_unknown(testDataTask2);

% frame policy = 128
[count2Unknown, prediction2Unknown] = testing_unlabeled_data(10, trainFeatureTable2Unknown, testFeatureTable2Unknown, struct([]));
fprintf('Data classified as not unknown (class 0): %d \n', count2Unknown("Class 0"));
fprintf('Data classified as unknown (class 1): %d \n', count2Unknown("Class 1"));





% [yfit,scores]=trainedModel1.predictFcn(notUnknownMembers);
% 
%     for i = 1:numWindow:len-numWindow+1
%         countOfTwo = sum(yfit(i:i+numWindow-1) == 2);
%         countOfThree = numWindow-countOfTwo;
%         if countOfTwo>=dueterzi
%             prediction = [prediction, 2];
%         else
%             prediction = [prediction, 3];
%         end
%     end