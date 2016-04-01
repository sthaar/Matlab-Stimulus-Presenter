function [eventNames,eventFiles,eventDir, eventMap ] = getEvents()
%GETEVENTS [eventNames,eventFiles,eventDir, eventMap ] = getEvents()
%   Get all enabled events from the eventDir directory (Events)
%   returns all the names of these events, the corresponding files, the
%   directory in which they reside and a eventMap.
%   The eventmap is een Containers.Map structure which uses hashable
%   indexes.
%   You can get a filename for a given eventName the following ways:
%   - Use the eventMap: eventFile = eventMap('eventName');
%   - Use index similarity: eventNames{1} => eventFiles{1};
%   Note: These are the filenames ONLY, the directory is not included.

%% settings
eventDir = 'Events';

files = dir(eventDir);
nFiles = length(files);
eventFiles = {};
eventNames = {};
it = 0;
prevPath = addpath(eventDir); % Add event directory to path (reset in the next section)
for iFile = 1:nFiles
    file = files(iFile);
    namewe = file.name(1:end-2);
    path_ = fullfile(eventDir,file.name);
    if exist(path_,'file')==2 && ~file.isdir && strcmp(file.name(end-1:end),'.m')
        try
            if eval([namewe, '(''enabled'')'])
                it = it + 1;
                res = eval([namewe, '(''getName'')']);
                eventNames{1,it} = res;
                eventFiles{1,it} = namewe;
                
            end
        catch
            it = it - 1; % Function did not exist.
        end
    end
end
path(prevPath);
eventMap = containers.Map(eventNames,eventFiles);

end

