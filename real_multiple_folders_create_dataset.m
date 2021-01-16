clc;
clear;
close all;
tic
rootdir = 'D:\UAV\MPACT_DroneRC_RF_Database\';
filelist = dir(fullfile(rootdir, '**\*.mat*'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);
Fs = 20e9;
names = fieldnames(filelist(1));
for jj = 1:numel(filelist)
    str2 = append(filelist(jj).folder,"\");
    str1 = filelist(jj).name;
    w = strcat(str2,str1);
    p(jj, :) = readDD_CPU(w, Fs);
%     clear p;
    disp(jj);
end
save('SomeSignals.mat', 'p', '-v7.3');
clear;
close all;
load p
toc