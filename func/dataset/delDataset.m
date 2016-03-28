function [ succes ] = delDataset( name )
%DELDATASET Summary of this function goes here
%   Detailed explanation goes here
succes = 0;
%% Settings
dataFolder = 'Data';
datasetInfofile = 'datainfo.mat';

%% Does it exist?
if ~datasetExists(name)
    warning('Dataset %s does not exist', name);
    succes = 1;
    return
end

%% Delete datasetInfofile
prevState = recycle('on');
delete(fullfile(dataFolder, name, datasetInfofile));

%% Do we want the files gone as well?
answer = questdlg('Do you want to delete the actual files as well? (only the ones In the Data folder, not anywhere else)'...
    , 'Deleting dataset files', 'yes', 'no', 'maybe','yes');
if strcmp(answer,'yes')
    p = fullfile(dataFolder,name);
    waitfor(warndlg(sprintf('This folder and all its content will be deleted: %s', p)));
    [status, message] = rmdir(p,'s');
    if ~status
        recycle(prevState);
        errordlg(sprintf('Folder was not deleted: %s', message));
        return
    end
end
if strcmp(answer, 'maybe')
    msgbox('That isnt a very usefull answer now, is it? Ill leave em in the folder...','Ugh...');
    return
end

%% Reset state
recycle(prevState);
succes = 1;
end

