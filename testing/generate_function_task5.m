function [featureTable,outputTable] = diagnosticFeatures(inputData)
%DIAGNOSTICFEATURES recreates results in Diagnostic Feature Designer.
%
% Input:
%  inputData: A table or a cell array of tables/matrices containing the
%  data as those imported into the app.
%
% Output:
%  featureTable: A table containing all features and condition variables.
%  outputTable: A table containing the computation results.
%
% This function computes spectra:
%  Case_ps/SpectrumData
%  Case_ps_1/SpectrumData
%  Case_ps_2/SpectrumData
%  Case_ps_3/SpectrumData
%  Case_ps_4/SpectrumData
%
% This function computes features:
%  Case_ps_spec/PeakAmp1
%  Case_ps_spec/PeakFreq1
%  Case_ps_spec/BandPower
%  Case_ps_1_spec/PeakAmp2
%  Case_ps_1_spec/PeakFreq2
%  Case_ps_2_spec/PeakFreq1
%  Case_ps_3_spec/PeakFreq1
%  Case_ps_4_spec/PeakFreq1
%  Case_sigstats/ShapeFactor
%  Case_sigstats_1/ShapeFactor
%  Case_sigstats_2/SINAD
%  Case_sigstats_3/SINAD
%  Case_sigstats_4/ShapeFactor
%
% Frame Policy:
%  Frame name: FRM_1
%  Frame size: 0.128 seconds
%  Frame rate: 0.128 seconds
%
% Organization of the function:
% 1. Compute signals/spectra/features
% 2. Extract computed features into a table
%
% Modify the function to add or remove data processing, feature generation
% or ranking operations.

% Auto-generated by MATLAB on 21-Feb-2024 15:12:00

% Create output ensemble.
outputEnsemble = workspaceEnsemble(inputData,'DataVariables',"Case",'ConditionVariables',"Task5");

% Reset the ensemble to read from the beginning of the ensemble.
reset(outputEnsemble);

% Append new frame policy name to DataVariables.
outputEnsemble.DataVariables = [outputEnsemble.DataVariables;"FRM_1"];

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = "Case";

% Loop through all ensemble members to read and write data.
while hasdata(outputEnsemble)
    % Read one member.
    member = read(outputEnsemble);

    % Read signals.
    Case_full = readMemberData(member,"Case",["TIME","P1","P2","P3","P4","P5"]);

    % Get the frame intervals.
    lowerBound = Case_full.TIME(1);
    upperBound = Case_full.TIME(end);
    fullIntervals = frameintervals([lowerBound upperBound],0.128,0.128,'FrameUnit',"seconds");
    intervals = fullIntervals;

    % Initialize a table to store frame results.
    frames = table;

    % Loop through all frame intervals and compute results.
    for ct = 1:height(intervals)
        % Get all input variables.
        Case = Case_full(Case_full.TIME>=intervals{ct,1}&Case_full.TIME<intervals{ct,2},:);

        % Initialize a table to store results for one frame interval.
        frame = intervals(ct,:);

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Case.TIME,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Case.P1;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Case_ps = ps;
        catch
            Case_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps},'VariableNames',{'Case_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Case.TIME,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Case.P2;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Case_ps_1 = ps;
        catch
            Case_ps_1 = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_1},'VariableNames',{'Case_ps_1'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Case.TIME,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Case.P3;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Case_ps_2 = ps;
        catch
            Case_ps_2 = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_2},'VariableNames',{'Case_ps_2'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Case.TIME,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Case.P4;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Case_ps_3 = ps;
        catch
            Case_ps_3 = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_3},'VariableNames',{'Case_ps_3'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Case.TIME,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Case.P5;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Case_ps_4 = ps;
        catch
            Case_ps_4 = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_4},'VariableNames',{'Case_ps_4'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Case_ps.SpectrumData;
            w = Case_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*5) & (w<=factor*100);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',1);
            peakAmp = [peakAmp(:); NaN(1-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(1-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakFreq1 = peakFreq(1);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakFreq1,BandPower];

            % Package computed features into a table.
            featureNames = {'PeakAmp1','PeakFreq1','BandPower'};
            Case_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,3);
            featureNames = {'PeakAmp1','PeakFreq1','BandPower'};
            Case_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_spec},'VariableNames',{'Case_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Case_ps_1.SpectrumData;
            w = Case_ps_1.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*5) & (w<=factor*175);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp2 = peakAmp(2);
            PeakFreq2 = peakFreq(2);

            % Concatenate signal features.
            featureValues = [PeakAmp2,PeakFreq2];

            % Package computed features into a table.
            featureNames = {'PeakAmp2','PeakFreq2'};
            Case_ps_1_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,2);
            featureNames = {'PeakAmp2','PeakFreq2'};
            Case_ps_1_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_1_spec},'VariableNames',{'Case_ps_1_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Case_ps_2.SpectrumData;
            w = Case_ps_2.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*5) & (w<=factor*100);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',1);
            peakAmp = [peakAmp(:); NaN(1-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(1-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakFreq1 = peakFreq(1);

            % Concatenate signal features.
            featureValues = PeakFreq1;

            % Package computed features into a table.
            featureNames = {'PeakFreq1'};
            Case_ps_2_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,1);
            featureNames = {'PeakFreq1'};
            Case_ps_2_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_2_spec},'VariableNames',{'Case_ps_2_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Case_ps_3.SpectrumData;
            w = Case_ps_3.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*5) & (w<=factor*100);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',1);
            peakAmp = [peakAmp(:); NaN(1-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(1-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakFreq1 = peakFreq(1);

            % Concatenate signal features.
            featureValues = PeakFreq1;

            % Package computed features into a table.
            featureNames = {'PeakFreq1'};
            Case_ps_3_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,1);
            featureNames = {'PeakFreq1'};
            Case_ps_3_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_3_spec},'VariableNames',{'Case_ps_3_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Case_ps_4.SpectrumData;
            w = Case_ps_4.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*5) & (w<=factor*100);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',1);
            peakAmp = [peakAmp(:); NaN(1-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(1-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakFreq1 = peakFreq(1);

            % Concatenate signal features.
            featureValues = PeakFreq1;

            % Package computed features into a table.
            featureNames = {'PeakFreq1'};
            Case_ps_4_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,1);
            featureNames = {'PeakFreq1'};
            Case_ps_4_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_ps_4_spec},'VariableNames',{'Case_ps_4_spec'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Case.P1;
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');

            % Concatenate signal features.
            featureValues = ShapeFactor;

            % Package computed features into a table.
            featureNames = {'ShapeFactor'};
            Case_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,1);
            featureNames = {'ShapeFactor'};
            Case_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_sigstats},'VariableNames',{'Case_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Case.P2;
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');

            % Concatenate signal features.
            featureValues = ShapeFactor;

            % Package computed features into a table.
            featureNames = {'ShapeFactor'};
            Case_sigstats_1 = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,1);
            featureNames = {'ShapeFactor'};
            Case_sigstats_1 = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_sigstats_1},'VariableNames',{'Case_sigstats_1'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Case.P3;
            SINAD = sinad(inputSignal);

            % Concatenate signal features.
            featureValues = SINAD;

            % Package computed features into a table.
            featureNames = {'SINAD'};
            Case_sigstats_2 = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,1);
            featureNames = {'SINAD'};
            Case_sigstats_2 = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_sigstats_2},'VariableNames',{'Case_sigstats_2'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Case.P4;
            SINAD = sinad(inputSignal);

            % Concatenate signal features.
            featureValues = SINAD;

            % Package computed features into a table.
            featureNames = {'SINAD'};
            Case_sigstats_3 = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,1);
            featureNames = {'SINAD'};
            Case_sigstats_3 = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_sigstats_3},'VariableNames',{'Case_sigstats_3'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Case.P5;
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');

            % Concatenate signal features.
            featureValues = ShapeFactor;

            % Package computed features into a table.
            featureNames = {'ShapeFactor'};
            Case_sigstats_4 = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Package computed features into a table.
            featureValues = NaN(1,1);
            featureNames = {'ShapeFactor'};
            Case_sigstats_4 = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Case_sigstats_4},'VariableNames',{'Case_sigstats_4'})];

        %% Concatenate frames.
        frames = [frames;frame]; %#ok<*AGROW>
    end

    % Write all the results for the current member to the ensemble.
    memberResult = table({frames},'VariableNames',"FRM_1");
    writeToLastMemberRead(outputEnsemble,memberResult)
end

% Gather all features into a table.
selectedFeatureNames = ["FRM_1/Case_ps_spec/PeakAmp1","FRM_1/Case_ps_spec/PeakFreq1","FRM_1/Case_ps_spec/BandPower","FRM_1/Case_ps_1_spec/PeakAmp2","FRM_1/Case_ps_1_spec/PeakFreq2","FRM_1/Case_ps_2_spec/PeakFreq1","FRM_1/Case_ps_3_spec/PeakFreq1","FRM_1/Case_ps_4_spec/PeakFreq1","FRM_1/Case_sigstats/ShapeFactor","FRM_1/Case_sigstats_1/ShapeFactor","FRM_1/Case_sigstats_2/SINAD","FRM_1/Case_sigstats_3/SINAD","FRM_1/Case_sigstats_4/ShapeFactor"];
featureTable = readFeatureTable(outputEnsemble,"FRM_1",'Features',selectedFeatureNames,'ConditionVariables',outputEnsemble.ConditionVariables,'IncludeMemberID',true);

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = unique([outputEnsemble.DataVariables;outputEnsemble.ConditionVariables;outputEnsemble.IndependentVariables],'stable');

% Gather results into a table.
outputTable = readall(outputEnsemble);
end
