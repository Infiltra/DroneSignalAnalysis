clc;
clear;
close all;
databasePath = 'D:\UAV\MPACT_DroneRC_RF_Database\';
Fs = 20e9;
NumSignals = 10;
db_read = createBD_RAW(databasePath, Fs, NumSignals, 'OnlyCroppedData', 'Table');