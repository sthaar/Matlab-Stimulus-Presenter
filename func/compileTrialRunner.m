function [ boolSucces ] = compileTrialRunner( varargin )
%% compileTrialRunner( events, template, desti )
%   compileTrialRunner compiles all the working events into a script
%   Compiles all Needed functions into one trial looping script.
boolSucces = false;

%% input
template = 'func/compileData/compileTrialScriptTemplate.m';
desti = 'func/runTrial.m';
eventDir = 'Events';

if nargin == 0
    error('Invalid compiler usage')
end
if nargin == 1
    events = varargin{1};
end
if nargin == 2
    template = varargin{2};
end
if nargin == 3
    template = varargin{3};
end

%% build paths
template = fullfile(cd,template);
desti = fullfile(cd,desti);
eventDir = fullfule(cd,eventDir);

%% checks
% Template must exist. Duhh..
if ~exist(template,'file')
    error('Specified template does not exist: %s', template);
end

if ~exist(eventDir,'dir')
    error('Events directory missing! (%s)', eventDir);
end

if ~isstruct(events)
    error('Invalid event list container. Container must be struct.');
end

if length(events) < 1
    error('Invalid event list: List is empty');
end

%% Index events
%Ignores random missing files....
% Errors for missing events are given lateron.
files = dir(eventDir);
nFiles = length(files);
eventFiles = {};
eventNames = {};
it = 0;
for iFile = nFiles
    it = it + 1;
    file = files{iFile};
    namewe = file.name(1:end-2);
    path = fullfile(cd,eventDir,file.name);
    if exist(path,'file') && ~file.isdir && strcmp(file.name(end-2:end),'.m')
        try
            res = eval([namewe, '(''getName'')']);
            eventNames{it} = res;
            eventFiles{it} = namewe;
        catch
            it = it - 1;
        end
    end
end

eventMap = containers.Map(eventNames,eventFiles);

%% Check if all events exist and load them
for event = events
    try
        eventFun = eventMap(event);
        %% TODO
    catch e
        if strcmp(e.identifier,'MATLAB:Containers:Map:NoKey')
            error('Missing event: %s',event)
        else
            rethrow(e)
        end
    end
end

%% Process/compile
% Open
try
    fTemplate = fopen(template,'r');
    fDesti = fopen(desti,'w+');
catch e
    print('A runtime error occured while compiling (fopen): \n',e.message);
    return
end

%write/read & insert
try
    
catch e
    print('A runtime error occured while compiling (write/read): \n',e.message);
    return
end