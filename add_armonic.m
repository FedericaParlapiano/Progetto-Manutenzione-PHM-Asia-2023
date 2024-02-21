import generate_function_task2_unknown.*

clc;
fs = 0.001;
t = 0:fs:1.2;
f = 1;
v1 = sin(2*pi*f*t);
v3 = 3*sin(2*pi*3*f*t);
v5 = 2*sin(2*pi*5*f*t);


noiseSignal = labeledData;

for i=1:10
    noiseSignal.Case{i,1}.P1 = (noiseSignal.Case{i,1}.P1' + v1+v5+v3)';
    noiseSignal.Case{i,1}.P2 = (noiseSignal.Case{i,1}.P2' + v1+v5+v3)';
    noiseSignal.Case{i,1}.P3 = (noiseSignal.Case{i,1}.P3' + v1+v5+v3)';
    noiseSignal.Case{i,1}.P4 = (noiseSignal.Case{i,1}.P4' + v1+v5+v3)';
    noiseSignal.Case{i,1}.P5 = (noiseSignal.Case{i,1}.P5' + v1+v5+v3)';
    noiseSignal.Case{i,1}.P6 = (noiseSignal.Case{i,1}.P6' + v1+v5+v3)';
    noiseSignal.Case{i,1}.P7 = (noiseSignal.Case{i,1}.P7' + v1+v5+v3)';
end

noiseSignal = head(noiseSignal,10);
noiseSignal(:,2) = {1};
labeledData = [labeledData; noiseSignal]

plot(t,labeledData.Case{i,1}.P1);
hold on
plot(t,noiseSignal.Case{i,1}.P1);
hold on
plot(t,v1+v3+v5);



[FeatureTable, x] = generate_function_task2_unknown(noiseSignal);

% dataFolder = 'dataset/train/data/';
% files = dir(fullfile(dataFolder, '*.csv'));
% 
% data = cell(1, numel(files));
% for i = 1:numel(files)
%     filePath = fullfile(dataFolder, files(i).name);
%     data{i} = readtable(filePath);
% end
% 
% plot(t, data{1,1}{:,2})
% 
% 
% t = 0:0.001:1.2;
% sin1 = 10*sin(2*pi*50*t).';
% sin2 = 3*sin(2*pi*3*50*t).';
% sin3 = 2*sin(2*pi*5*50*t).';
% 
% for i=1:10
%     for j=2:8
%         data_pj=data{1,i}{:,j};
%         data{1,i}{:,j}=data_pj+sin1+sin2+sin3;
%     end
% end
% 
% plot(t, data{1,1}{:,2})