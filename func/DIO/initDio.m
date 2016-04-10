function [ succes ] = initDio()
%INITDIO Finds the dio devices and looks through the config to init an
%configured dio device according to its config file
%% Start waitbar
hWait = waitbar(0,'Init DIO...');
%%
clear global diosessions
global diosessions
% struct:
%     .devname
%     .session
%     .channels  (names from config)
%     .nOut (for outputSingleScan)
%     .nIn
%     .outState (vector with 0 and 1 that should be the state)
% .channels{} contains:
%     struct:
%         .direction
%         .name
%         .id


succes = 0;
configDirs = { '';...
    'func/DIO'...
    };

fprintf('Checking for dio devices...\n');

%% Start waitbar
waitbar(0,hWait,'Loading dio config...');

%% Load config
DioDevices = struct;
iter=0;
for i=1:length(configDirs)
    cdir = configDirs{i};
    files = dir(fullfile(cdir,'*.conf'));
    for file=files
        try
            [devname channels ] = parseConfig(fullfile(cdir,file.name));
            if ~empty(devname)
                iter = iter + 1;
                DioDevices(iter).name = devname;
                DioDevices(iter).channels = channels;
                fprintf('Found config for %s\n', devname);
            end
        catch e
            warning('Invalid DIO config: %s',file.name);
        end
    end
end
%% Start looking for the first configured dio device
waitbar(0,hWait,'Device discovery...');
devs = daq.getDevices();
devnames = {};
sessions = {};
try
    for i=1:length(devs)
        dev = devs(i);
        fprintf('Found device: %s\n', dev.Model);
        idx = find(strcmp('USB-6501',{DioDevices.name}));
        if ~isempty(idx)
            nOut = 0;
            nIn = 0;
            waitbar(0,hWait,'Device init...');
            fprintf('Config match!\n');
            dio = DioDevices(idx);
            fprintf('Creating session: %s\n',dev.Vendor.ID);
            diosession = daq.createSession(dev.Vendor.ID);
            for j=1:length(dio.channels)
                waitbar(j/length(dio.channels),hWait,sprintf('Adding channels to %s...',dev.Model));
                addDigitalChannel(diosession, dev.ID, dio.channels{j}.id, dio.channels{j}.direction);
                if strcmpi(dio.channels{j}.direction,'OutputOnly')
                    nOut = nOut + 1;
                elseif strcmpi(dio.channels{j}.direction,'InputOnly')
                    nIn = nIn + 1;
                else
                    nIn = nIn + 1;
                    nOut = nOut + 1;
                end
            end
            waitbar(1,hWait,'Finalizing...');
            try
                startBackground(diosession) % Preferred
            catch
                %warning('Unable to start background session:\nSession contains channels that only support ondemand opperations');
            end
            sess = struct;
            sess.devname = dev.Model;
            sess.session = diosession;
            sess.channels = dio.channels;
            sess.nIn = nIn;
            sess.nOut = nOut;
            sess.outState = zeros(1,nOut);
            sess.session.outputSingleScan(sess.outState);
            devnames = [devnames {dev.Model}];
            sessions = [sessions {sess}];
            succes = 1;
        end
    end
    diosessions = containers.Map(devnames, sessions);
catch e
    clear global diochannels
    clear global diosession
    warning('Dio init failed!\n%s', e.message);
    succes = 0;
end
delete(hWait);