function plot_data(FeatureTable, prediction, task)

FeatureSelection = FeatureTable(:, [1 2 5 6 7]);

for i=1:height(FeatureSelection)
    ensamble = strcat("Member ", num2str(i));
    FeatureSelection.EnsembleID_(FeatureSelection.EnsembleID_==ensamble)=i;
end

FeatureArray = table2array(FeatureSelection);
FeatureArray = str2double(FeatureArray(:,[1 2 3 4 5]));

group_by = FeatureArray(:,1);
medie_per_caso = grpstats(FeatureArray(:, 3:5), group_by, {'mean'});

plot_xyz = [medie_per_caso, prediction'];

% feature da utilizzare per il colore dei punti nel plot
gruppo = prediction;

x = plot_xyz(:,1);
y = plot_xyz(:,2);
z = plot_xyz(:,3);

if task==1
    figure;
    scatter3(x(gruppo == 0), y(gruppo == 0), z(gruppo == 0), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50, 'magenta', 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('Normal', 'Abnormal', 'Location','best');

elseif strcmp(task,'unknown')
    figure;
    scatter3(x(gruppo == 0), y(gruppo == 0), z(gruppo == 0), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50, 'magenta', 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('Classe 0', 'Classe 1', 'Location', 'best');

elseif task==2
    figure;
    scatter3(x(gruppo == 2), y(gruppo == 2), z(gruppo == 2), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 3), y(gruppo == 3), z(gruppo == 3), 50, 'magenta', 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('Bubble anomaly', 'Solenoid fault', 'Location','best');

elseif task==3
    figure;
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50,"green", 'filled');
    hold on;
    scatter3(x(gruppo == 2), y(gruppo == 2), z(gruppo == 2), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 3), y(gruppo == 3), z(gruppo == 3), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 4), y(gruppo == 4), z(gruppo == 4), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 5), y(gruppo == 5), z(gruppo == 5), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 6), y(gruppo == 6), z(gruppo == 6), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 7), y(gruppo == 7), z(gruppo == 7), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 8), y(gruppo == 8), z(gruppo == 8), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 3), y(gruppo == 3), z(gruppo == 3), 50, 'magenta', 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('BP1', 'BP2', 'BP3', 'BP4', 'BP5', 'BP6', 'BP7', 'BV1', 'Location','best');

elseif task==4
    figure;
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50,"green", 'filled');
    hold on;
    scatter3(x(gruppo == 2), y(gruppo == 2), z(gruppo == 2), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 3), y(gruppo == 3), z(gruppo == 3), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 4), y(gruppo == 4), z(gruppo == 4), 50, 'yellow', 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('SV1', 'SV2', 'SV3', 'SV4', 'Location','best');
else
    figure;
    scatter3(x(gruppo == 0), y(gruppo == 0), z(gruppo == 0), 50,"green", 'filled');
    hold on;
    scatter3(x(gruppo == 25), y(gruppo == 25), z(gruppo == 25), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 50), y(gruppo == 50), z(gruppo == 50), 50, 'yellow', 'filled');
    hold on;
    scatter3(x(gruppo == 75), y(gruppo == 75), z(gruppo == 75), 50, 'yellow', 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('SV1', 'SV2', 'SV3', 'SV4', 'Location','best');
end




