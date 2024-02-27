import diagnosticFeatures.*;
import generate_function_task2.*

signalData = labeledData;

for i=1:10
    for j=2:8
        signal = signalData.Case{i,1}{:,j};
    
        % Genera un rumore compreso tra 0 e 1
        noise = rand(size(signal));
        
        max_signal = max(signal);
        min_signal = min(signal);
        
        % Scala il rumore sulla base del massimo e del minimo del segnale
        scaled_noise =  0.4 * noise;
        
        % Aggiungi il rumore al segnale
        noise_signal = signal + scaled_noise;
        
        signalData.Case{i,1}{:,j} = noise_signal;
    end
end

signalData = head(signalData,10);
signalData(:,2) = {1};

figure(1);
plot(signal);
hold on;
plot(noise_signal, 'r');


[FeatureTable, x] = generate_function_task2_unknown(signalData);
testTable = FeatureTable;


