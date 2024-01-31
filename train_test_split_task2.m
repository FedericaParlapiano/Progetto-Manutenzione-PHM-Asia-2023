% fino a 105 normal, da 106 a 153 fault, da 154 a 177 anomaly

% stratified splitting 80-20
testPercentage = 20;
faultTestPercentage = int32(48*testPercentage/100);
anomalyTestPercentage = int32(24*testPercentage/100);

% num windows
numWindow = 10;

trainTable = FeatureTable1;

anomalyTest = trainTable(48*numWindow+1:(anomalyTestPercentage+48)*numWindow,:);
trainTable(48*numWindow+1:(anomalyTestPercentage+48)*numWindow,:) = [];

faultTest = trainTable(1:faultTestPercentage*numWindow,:);
trainTable(1:faultTestPercentage*numWindow,:) = [];

testTable = [faultTest; anomalyTest];