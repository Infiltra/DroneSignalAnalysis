function droneRC_RFDatabase = createBD_RAW(databasePath,Fs,NumSignals,opts,varargin)
%databasePath - path to your database
%Fs - sampling rate
%NumSignals - total number of signals
%opts - options of data to include
%varargin - argin variable
%
narginchk(4, 5)
folderList = dir(databasePath);
% disp(folderList);
folderList = folderList(3:end);
% disp(folderList)
NumDroneRCs = length(folderList);
% disp(NumDroneRCs)
droneTable = table;
% disp(droneTable)
fields_ = properties(readDD_CPU);
% disp(1)
% disp(fields_)
for droneType = 1:NumDroneRCs
    addpath([databasePath folderList(droneType).name '\']);
    fileList = dir([databasePath folderList(droneType).name '\', '*.mat']);
%     disp(fileList)
    for selectSignal = 1:NumSignals
        clc;
        %display progess
        fprintf('Creating database...\nController:%d/%d... %%%d\n',droneType,...
            NumDroneRCs,round((droneType-1)/NumDroneRCs*100+ selectSignal/NumSignals/NumDroneRCs*100));
        newEntry = readDD_CPU(fileList(selectSignal).name,Fs,opts);
%         disp(newEntry)
%         disp(2)
        if ~isempty(varargin) && strcmp(varargin(1), 'Table')
            row_ = cell(1, numel(fields_));
%             disp(fields_)
%             disp(row);
            for p = 1:numel(fields_)
%                 disp(numel(fields_));
%                 disp(newEntry.(fields_{p}));
                row_{p} = newEntry.(fields_{p});
            end
            droneTable = [droneTable;cell2table(row_)];
        elseif isempty(varargin)
            droneRC_RFDatabase{droneType,selectSignal} = newEntry;
        else
            error('Invalid i/p argumets')
        end
    end
end

if ~isempty(varargin) && strcmp(varargin{1}, 'Table')
    droneTable.Properties.VariableNames = fields_;
    droneRC_RFDatabase = droneTable;
end

end