clc;
clear;
close all;
fileName = 'D:\UAV\MPACT_DroneRC_RF_Dataset\DJI_Inspire1Pro\DJI_Inspire1Pro_0001.mat';
Fs = 20e9;
d = readDD(fileName, Fs);%call readDD fuction for reading the file metadata
max(d.RawData);
min(d.RawData);
R = d.RawData;%Raw Data Storage Variable
% plot(R);hold on;
C = d.CroppedData;%Cropped Data Storage Variable
SF = d.ScaleFactor;
% plot(C);
p = procDD(R, C, Fs, SF);
[w,f,t] = pspectrum(p.ampCCPU, Fs, 'spectrogram', 'FrequencyLimits', [0 d.Fs/2], ...
    'TimeResolution', 1*10^-6, 'Leakage', 0.85, 'OverlapPercent', 2);
figure('Name', 'Full View')
waterfall(f,t,w')
xlabel('Frequency(Hz)')
ylabel('Time (s)')
wtf = gca;
wtf.XDir = 'reverse';
n = 2^nextpow2(length(p.ampCCPU));
Y = fft(p.ampCCPU, n);
X = d.Fs*(0:(n/2))/n;
P = abs(Y/n);
f = d.Fs*(0:(n/2))/n;
figure('Name', 'FFT')
plot(f, P(1:n/2+1));
grid on;