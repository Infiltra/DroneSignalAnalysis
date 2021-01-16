clc;
clear;
close all;
load SomeSignals.mat;
for ii = 1:length(p)
    plot(p(ii).timeVector, p(ii).CroppedData*p(ii).ScaleFactor);hold on;
    
end