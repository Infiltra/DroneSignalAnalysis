clc;
close all;
clear;Fs = 20e9;
%this program prototypes the window and all thit factor as such for our
%sample rate Fs = 2Gsps
fileName = 'D:\UAV\MPACT_DroneRC_RF_Dataset\DJI_Inspire1Pro\DJI_Inspire1Pro_0001.mat';
d = readDD(fileName, Fs);%call readDD fuction for reading the file metadata
% Start a kaiser window
bw_k = enbw(kaiser(d.NumSamples), d.Fs);
bw_ft = enbw(flattopwin(d.NumSamples), d.Fs);
bw_hm = enbw(hamming(d.NumSamples), d.Fs);
bw_ha = enbw(hanning(d.NumSamples), d.Fs);
R = d.RawData;%Raw Data Storage Variable
% plot(R);hold on;
C = d.CroppedData;%Cropped Data Storage Variable
SF = d.ScaleFactor;
% plot(C);
y = [1, 2, 3];
p = procDD(R, C, Fs, SF);
%Algorithm for RBW theory
RBW_T_k = (bw_k)/(max(p.timeCropped) - min(p.timeCropped));
RBW_T_ft = (bw_ft)/(max(p.timeCropped) - min(p.timeCropped));
RBW_T_hm = (bw_hm)/(max(p.timeCropped) - min(p.timeCropped));
RBW_T_ha = (bw_ha)/(max(p.timeCropped) - min(p.timeCropped));
% figure();
% plot(y(1), RBW_T_k, 'b--o', y(2), RBW_T_ft, 'c--o', y(3), RBW_T_hm, 'g--o');
% grid on;
% figure()
% plot(y(1), bw_k, 'b--o', y(2), bw_ft, 'c--o', y(3), bw_hm, 'g--o');
% grid on;
f_span = [0 d.Fs/2];%frequenncy span of the system
for pp = length(f_span)
    RBW_P(pp) = 4*(f_span(pp)/(4096-1));%Perform a lowest resolution bandwidth
end
RBW_F_k = max(RBW_T_k, max(RBW_P))
RBW_F_ft = max(RBW_T_ft, max(RBW_P))
RBW_F_hm = max(RBW_T_hm, max(RBW_P))
RBW_F_ha = max(RBW_T_ha, max(RBW_P))
%Enough of that now let us tool the windows 
figure('Name', 'Kaiser window with N=768')
w_k = kaiser(768, 2.5);
plot(w_k);
grid on;
figure('Name', 'Flat Top Window with N=768')
w_ft = flattopwin(768, 'periodic');
plot(w_ft);
grid on;
figure('Name', 'Hamming Window with N=768 for spectral')
w_hm = hamming(768, 'periodic');
plot(w_hm);
grid on;
figure('Name', 'Hanning Window with N=768 for spectral')
w_ha = hann(768, 'periodic');
plot(w_ha);
grid on;
figure();
freqz(w_k,768);
figure();
freqz(w_ft,768);
figure();
freqz(w_hm,768);
figure();
freqz(w_ha,768);