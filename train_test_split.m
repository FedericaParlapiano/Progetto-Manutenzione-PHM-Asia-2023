% fino a 105 normal, da 106 a 177 abnormal

testPercentage = 20;
normalTestPercentage = int32(105*testPercentage/100);
abnormalTestPercentage = int32((177-105)*testPercentage/100);
numWindow = 19;

trainTable = FeatureTable1;

abnormalTest = trainTable(105*numWindow+1:(abnormalTestPercentage+105)*numWindow,:);
trainTable(105*numWindow+1:(abnormalTestPercentage+105)*numWindow,:) = [];

normalTest = trainTable(1:normalTestPercentage*numWindow,:);
trainTable(1:normalTestPercentage*numWindow,:) = [];


testTable = [normalTest; abnormalTest];