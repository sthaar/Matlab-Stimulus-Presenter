function [ runtimeExperiment ] = generateExperiment( generatorPackage )
%GENERATEEXPERIMENT Summary of this function goes here
%   Detailed explanation goes here
%% Unpack
experiment = generatorPackage.expData;
runmode = generatorPackage.runMode;
startMessage = generatorPackage.startMessage;
startDelay = generatorPackage.startDelay;
interTDelay = generatorPackage.interTDelay;

%% Reassign
rte = struct;
creator = experiment.creator; % The creator events
name = experiment.name;
%% Set name and creation date and time
rte.name = name;
rte.date = date();
c = clock();
rte.time = sprintf('%i:%i', c(4), c(5));
%% Set experiment info
rte.nRepeats = 1;
rte.nTrials = 0; %Set it later
rte.startDelay = 5; %make it variable
rte.interTrialDelay = 3; %make it variable
rte.runMode = runmode; %1 = preload; 0 = no preload
rte.preMessage = 'Welcome to the experiment! Press anykey to start'; % variable it must be!

%% Datasets
datasetNames = {};
datasets = {};
datasetIter = 0;
for i=1:length(creator) %For block in blocks
    block = creator{i}; %block struct
    events = block.events; %Êvent cell
    for j=1:length(events)
        event = events{1};
        if isfield(event,'dataset')
            datasetname = event.dataset;
            if sum(strcmp(datasetname,datasetNames)) == 0
                datasetIter = datasetIter + 1;
                datasetInfo = getDataset(datasetname);
                datasetFiles = {};
                for k=1:length(datasetInfo.files)
                    file = datasetInfo.files{k};
                    file = fullfile(cd,datasetname,file);%Change to using datasetInfo.fullPath
                    datasetFiles{k} = file;
                end
                datasets{datasetIter} = datasetFiles;
                datasetNames{datasetIter} = datasetname;
            end
        end
    end
end

if ~isempty(datasets)
    % Get the corresponding files for each dataset used
    datasets = containers.Map(datasetNames,datasets);
    % get the iter for non-random data selection without putback
    datasetIters = containers.Map(datasetNames,zeros(1,length(datasetNames)));
end

%% Create events
% eventStruct.dataset = dataset;
% eventStruct.randomData = random;
% eventStruct.putBack = putBack;
rte.trials = {}; %Blocks
%rte.trials(1).events = {};
for i=1:length(creator) %For block in blocks
    block = creator{i}; %block struct
    events = block.events; %Êvent cell
    trial = {};
    for j=1:length(events)
        event = events{j};
        %Get random data from dataset if random is needed
        if isfield(event, 'dataset')
            dataset = datasets(event.dataset);
            index = 0;
            if event.randomData
                index = randi(length(dataset));
            else % it start at 0, we add one every time.
                datasetIters(event.dataset) = datasetIters(event.dataset) + 1;
                index = datasetIters(event.dataset);
            end
            events{j}.data = dataset{index};
            if ~event.putBack
                dataset(index) = [];
                datasets(event.dataset) = dataset;
            end
        end
        trial{j} = events{j};
    end
    rte.trials{i} = trial;
end
runtimeExperiment = rte;
end

