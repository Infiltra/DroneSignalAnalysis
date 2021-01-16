classdef readDD_CPU
    %readDD 
    %readDD is a function class written to process data as GPU arrays
    %Make: Drone Manufaturer
    %Model: Drone Model
    %Fs: Sampling rate provided from documentation
    %Index: Sample Index number Recoreded from Sample
    %NumSamples: Total samples recorded
    %ScaleFactor: Amplitude Scaling factor due to point conversions
    %Duration: NumSamples/Fs
    %RawData: The data captured from the front end
    %CroppedData: Time Applied Cropped Data to avoid Memory Issues
    %Usage: declare fileName = 'path/to/file/filename/file'
    %foo = readDD(fileName)
    %foo
    %plotting of Raw and Cropped data can be directly called from the
    %varialbe like the one given below
    %plot(foo.RawData)
    %plot(foo.CroppedData)
    
    properties
        Make
        Model
        Index
        Fs = 20e9;
        NumSamples
        ScaleFactor
        Duration
        timeVector
        RawData
        CroppedData = [];
        Features = [];
    end
    methods
        function DrDD = readDD_CPU(fileName,Fs,varargin)
            narginchk(0,3)
            if nargin == 0
                return
            end
            splittedFileName = strsplit(fileName, '\');
            makeModelID = splittedFileName{end};
            splittedMakeModelID = strsplit(makeModelID, '_');
            DrDD.Make = splittedMakeModelID{1};
            if numel(splittedMakeModelID) == 4
                DrDD.Model = [splittedMakeModelID{2} '-' splittedMakeModelID{3}];
                DrDD.Index = splittedMakeModelID{4}(1:end-4);
            else
                DrDD.Model = splittedMakeModelID{2};
                DrDD.Index = splittedMakeModelID{3}(1:end-4);
            end
            load(fileName, 'data')
            g = gpuDevice(1);
%             DrDD.RawData = gpuArray(double(data.Data-mean(data.Data)));
            
            DrDD.ScaleFactor = data.YInc;
            startCrop = 2.4*10^6;
            endCrop = 5*10^6;
            DrDD.RawData = gpuArray(double(data.Data-mean(data.Data)));
            DrDD.CroppedData = gpuArray(double(data.Data(startCrop:endCrop)));
            DrDD.CroppedData = gather(DrDD.CroppedData);
            DrDD.NumSamples = data.NumPoints;
            DrDD.timeVector = gpuArray((1:numel(DrDD.CroppedData))/DrDD.Fs);
            DrDD.timeVector = gather(DrDD.timeVector);
            DrDD.Fs = Fs;
            DrDD.Duration = data.NumPoints/DrDD.Fs;
%             fprintf('Resetting GPU \n');
%             reset(g);
%             fprintf('GPU Reset \n');
            if isempty(varargin) || ( ~isempty(varargin) && strcmp(varargin{1},'OnlyRawData') )
                DrDD.CroppedData = [];
            elseif ( ~isempty(varargin) && strcmp(varargin{1},'OnlyCroppedData') )
                DrDD.RawData = [];
            else
                error('Invalid option!')
            end

        end
    end
end