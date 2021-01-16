clc;
clear;
close all;
rootdir = 'D:\UAV\MPACT_DroneRC_RF_Database\';
filelist = dir(fullfile(rootdir, '**\*.mat*'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);
Fs = 20e9;
names = fieldnames(filelist(1));
for ii = 1:numel(filelist)
%     filelist(ii)
    str1 = filelist(ii).name;
    str2 = append(filelist(ii).folder,"\");
    w = strcat(str2,str1);
    p(ii, :) = readDD(w, Fs);
end