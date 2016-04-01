function [ succes, missingEvents, missingDatasets, corrupt, doesNotExist ] = verifyExperiment( name )
%VERIFYE Summary of this function goes here
%   [ succes, missingEvents, missingDatasets, corrupt, doesNotExist ] = verifyExperiment( name)

%%
succes = 1;
missingEvents = {};
missingDatasets = {};
corrupt = 0;
doesNotExist = 0;

%% Check
if ~experimentExists( name )
    doesNotExist = 1;
    return
end

%% Open
try
    data = getExperiment(name);
    if isempty(data)
        corrupt = 1;
        succes = 0;
        return
    end
    
    for database = data.datasetDep
        if sum(strcmp(database{1}, getDatasets())) < 1
            fprintf('%s: missing database %s',name,database{1});
            missingDataset = [missingDatasets; database];
            succes = 0;
        end
    end
%% TODO
%     for event = data.eventDep
%         if sum(strcmp(event{1}, getEvents())) < 1
%             fprintf('%s: missing event %s',name,event{1});
%             missingDataset = [missingDatasets; event];
%         end
%     end
    warning('Event checker not implemented');
    
catch e
    warning('Unknown problem: %s', e.message);
    succes = 0;
end


end

