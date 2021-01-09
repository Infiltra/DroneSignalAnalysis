classdef procDD
    properties
        timeRaw
        amplitudeRaw
        timeCropped
        amplitudeCropped
        ampCCPU
        
    end
    methods
        function DrRaw = procDD(R, C, Fs, SF, varargin)
            narginchk(0,5)
            if nargin == 0
                return
            end
            DrRaw.timeRaw = gpuArray(((1:numel(R))/Fs));
            DrRaw.amplitudeRaw = gpuArray((R*SF));
            DrRaw.timeCropped = gpuArray(((1:numel(C))/Fs));
            DrRaw.amplitudeCropped = gpuArray((C*SF));
            DrRaw.ampCCPU = gather(C);
            figure();
            pspectrum(DrRaw.ampCCPU, Fs, 'FrequencyLimits', [0 Fs/2]);
            figure();
            pspectrum(DrRaw.ampCCPU, Fs, 'spectrogram', 'FrequencyLimits', [0 Fs/2], ...
    'TimeResolution', 1*10^-6, 'Leakage', 0.85, 'OverlapPercent', 2);
            %calculate the spectral entropy of the signal
            figure()
            pentropy(DrRaw.ampCCPU,Fs)
            %estimate the instantaneous Freq
            figure()
            instfreq(DrRaw.ampCCPU,Fs)
            %get the 3dB bandwidth
            powerbw(DrRaw.ampCCPU,Fs)
            %get the occupied bandwidth
            obw(DrRaw.ampCCPU,Fs)
            %get the spectral krutosis
            pkurtosis(DrRaw.ampCCPU,Fs)
            %compute spectral kurtogram
            kurtogram(DrRaw.ampCCPU,Fs)
        end
    end
end