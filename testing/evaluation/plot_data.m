function plot_data(FeatureTable, prediction, task, type)

newcolors = [
    1.00 0.65 0.00  % Arancione
    1.00 1.00 0.00  % Giallo
    0.50 0.00 1.00  % Viola
    1.00 0.00 1.00  % Magenta
    1.00 0.00 0.50  % Rosa
    0.00 0.50 1.00  % Azzurro
    0.00 1.00 1.00  % Ciano
    0.00 0.50 0.50  % Verde acqua
];

FeatureSelection = FeatureTable(:, [1 2 5 6 7]);

for i=1:height(FeatureSelection)
    ensemble = strcat("Member ", num2str(i));
    FeatureSelection.EnsembleID_(FeatureSelection.EnsembleID_==ensemble)=i;
end

FeatureArray = table2array(FeatureSelection);
FeatureArray = str2double(FeatureArray(:,[1 2 3 4 5]));

group_by = FeatureArray(:,1);
medie_per_caso = grpstats(FeatureArray(:, 3:5), group_by, {'mean'});

prediction = prediction;
plot_xyz = [medie_per_caso, prediction];

% feature da utilizzare per il colore dei punti nel plot
gruppo = prediction;

x = plot_xyz(:,1);
y = plot_xyz(:,2);
z = plot_xyz(:,3);

if strcmp(type, 'actual')
    figure;
    scatter3(x(gruppo == 0), y(gruppo == 0), z(gruppo == 0), 50, 'red', 'filled');
    hold on;
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50, 'green', 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('Wrong','Right', 'Location','best');

elseif task==1
    figure;
    colororder(newcolors);
    scatter3(x(gruppo == 0), y(gruppo == 0), z(gruppo == 0), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50, 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('Normal', 'Abnormal', 'Location','best');

elseif strcmp(task,'unknown')
    figure;
    colororder(newcolors(end-1:end, :));
    scatter3(x(gruppo == 0), y(gruppo == 0), z(gruppo == 0), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50, 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('Known', 'Unknown', 'Location', 'best');

elseif task==2
    figure;
    colororder(newcolors(end-4:end-2, :));
    scatter3(x(gruppo == 2), y(gruppo == 2), z(gruppo == 2), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 3), y(gruppo == 3), z(gruppo == 3), 50, 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('Bubble anomaly', 'Solenoid fault', 'Location','best');

elseif task==3
    figure;
    colororder(newcolors);
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 2), y(gruppo == 2), z(gruppo == 2), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 3), y(gruppo == 3), z(gruppo == 3), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 4), y(gruppo == 4), z(gruppo == 4), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 5), y(gruppo == 5), z(gruppo == 5), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 6), y(gruppo == 6), z(gruppo == 6), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 7), y(gruppo == 7), z(gruppo == 7), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 8), y(gruppo == 8), z(gruppo == 8), 50, 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('BP1', 'BP2', 'BP3', 'BP4', 'BP5', 'BP6', 'BP7', 'BV1', 'Location','best');

elseif task==4
    figure;
    colororder(newcolors);
    scatter3(x(gruppo == 1), y(gruppo == 1), z(gruppo == 1), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 2), y(gruppo == 2), z(gruppo == 2), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 3), y(gruppo == 3), z(gruppo == 3), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 4), y(gruppo == 4), z(gruppo == 4), 50,'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('SV1', 'SV2', 'SV3', 'SV4', 'Location','best');

else
    figure;
    colororder(newcolors);
    scatter3(x(gruppo == 0), y(gruppo == 0), z(gruppo == 0), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 25), y(gruppo == 25), z(gruppo == 25), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 50), y(gruppo == 50), z(gruppo == 50), 50, 'filled');
    hold on;
    scatter3(x(gruppo == 75), y(gruppo == 75), z(gruppo == 75), 50, 'filled');
    hold off;
    grid on;
    
    xlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,3}, "_", " "), "FRM 1/", " "));
    ylabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,4}, "_", " "), "FRM 1/", " "));
    zlabel(strrep (strrep(FeatureSelection.Properties.VariableNames{1,5}, "_", " "), "FRM 1/", " "));
    title('Plot dei dati');
    
    legend('0', '25', '50', '75', 'Location','best')
end

fig_name = strcat('image/sep_task', num2str(task), type);
saveas(gcf, strcat(fig_name, '.png'));



