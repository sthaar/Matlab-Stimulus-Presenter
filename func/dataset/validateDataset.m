function [ intact, missingFiles, invalidInfoFile, doesNotExist] = validateDataset( name )
%VALIDATEDATASET Validates dataset integrity
% [ intact, missingFiles, invalidInfoFile, doesNotExist] = validateDataset( name )
%   Checks if there are missingFiles.
%   Checks if the info is present
%   Checks if the dataset exists
%% vars
intact = 1;
missingFiles = 0;
invalidInfoFile = 0;
doesNotExist = 0;

%% Settings
dataFolder = 'Data';
datasetInfofile = 'datainfo.mat';

%% Does it exist?
if ~datasetExists(name)
    intact = 0;
    doesNotExist = 0;
    return
end

%% It does exist: Check if the info is present (struct in .mat file)
fields = {'settings', 'nFiles', 'name', 'files', 'createdDate', 'filetype' };
file = fullfile(dataFolder,name, datasetInfofile);
load(file);
for f = fields
    if ~isfield(datasetInfo, f{1})
        intact = 0;
        invalidInfoFile = 1;
        warning('Missing info field: %s', f{1});
        if strcmp(f{1}, 'files') || strcmp(f{1}, 'filetype')
            warning('Field "%s" is critical', f{1});
        end
    end
end

%% Validate files
if isfield(datasetInfo, 'files') 
    files = datasetInfo.files;
    for i = 1:length(files);
        file = files{i};
        if ~exist(fullfile(dataFolder,name, file))
            missingFiles = 1;
            intact = 0;
            warning('File missing: %s', file);
        end
    end
end
end

