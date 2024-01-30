% fino a 105 normal, da 106 a 153 fault, da 154 a 177 anomaly

% stratified splitting 80-20
testPercentage = 20;
normalTestPercentage = int32(105*testPercentage/100);
faultTestPercentage = int32((153-105)*testPercentage/100);
anomalyTestPercentage = int32((177-153)*testPercentage/100);


% num windows
numWindow = 19;

trainTable = FeatureTable1_2;

anomalyTest = trainTable(153*numWindow+1:(anomalyTestPercentage+153)*numWindow,:);
trainTable(153*numWindow+1:(anomalyTestPercentage+153)*numWindow,:) = [];

faultTest = trainTable(105*numWindow+1:(faultTestPercentage+105)*numWindow,:);
trainTable(105*numWindow+1:(faultTestPercentage+105)*numWindow,:) = [];

normalTest = trainTable(1:normalTestPercentage*numWindow,:);
trainTable(1:normalTestPercentage*numWindow,:) = [];


testTable = [normalTest; faultTest; anomalyTest];