%% Test data:
% sec to sec;
% 0.0000-0.9698(0.9698): Load and start playing flac (will be placed
% outside trial)
% 0.9698-5.9700(5.0002): Wait 5 sec
% 5.9700-6.0713(0.1013): Load and draw image (loading will be placed
% oudside trial)
% 6.0713-6.0745(0.0032): Show image (this will be image timing)
% 6.0745-9.0746(3.0001): wait 3 seconds
% 9.0746-9.0927(0.0181): end all sound
%Concl: Events cost <1ms; With the exception of disk events. Loading data
%will be placed before each trial to reduce timings to minimum

%% Create experiment
clear all;
ExperimentData = {};
ExperimentData.nRepeats         = 2;%Done
ExperimentData.nTrials          = 1;%done
% the above states:
% There is only one trial, but this will be repeated once (nRepeats is not
% really X repeats but more run X times... Logic is strong in this one)

ExperimentData.trials           = struct;%done
ExperimentData.startDelay       = 5;%Done
%The above states: Start experiment after 5 seconds.

ExperimentData.interTrialDelay  = 3;%Done
%The above states: Start each trial after 3 seconds of rest.

ExperimentData.runMode          = 1;%preload
%The above states, runMode 0. Meaning timings dont matter (for movies for example). Just load when
%something is needed. More modes will be created.

ExperimentData.name             = 'Test experiment';% Used
ExperimentData.preMessage       = ...
    'Test message, running test experiment after pressing anykey...'; %used as well
%This message.... displayed somewhere in the beginning....

event = {};
event.type = 'sound';
event.data = 'TheTrail.flac';
event.id   =  1;
%Event id, funny... Forgot what it did.... Its quite important:
% Event id is a event identifier (no sh.. sherlock). 
% The important part is, you need this ID to stop the music from playing!
% Without the ID, you can only use 'StopAllSounds' instead of just one
% specific sound. This way, multiple sounds can be managed. (like small
% auditory stimuli during music or something)

events(1).event = event;

event = {};
event.type = 'delay';
event.data = 5;

events(2).event = event;

event = {};
event.type = 'drawImage';
event.data = 'test.jpg';

events(3).event = event;

event = {};
event.type = 'show/clear';

events(4).event = event;

event = {};
event.type = 'delay';
event.data = 3;

events(5).event = event;

event = {};
event.type = 'endSoundAll';

events(6).event = event;

trials(1).events = events;

ExperimentData.trials = trials;

%% Datastruct test
trials = ExperimentData.trials; %runExperiment
trial = trials(1);              %runExperiment
%runTrial:
trialData = trial.events;
nEvents = length(trialData);
event = trialData(1).event;
event2 = trialData(2).event;


%% Run_experiment
%Screen('Preference', 'SkipSyncTests', 1);
oldLevel = Screen('Preference', 'Verbosity', 0);
try
    hW = initWindowBlack(ExperimentData.preMessage);
catch e
    EndofExperiment;
    if strcmp(e.message,'See error message printed above.')
        try
            disp('Warning, skipping sync tests!')
            Screen('Preference', 'SkipSyncTests', 1);
            hW = initWindowBlack(ExperimentData.preMessage);
        catch e
            rethrow(e)
        end
    else
        rethrow(e);
    end
end
Data = runExperiment(ExperimentData,hW);
EndofExperiment;
Screen('Preference', 'Verbosity', oldLevel);



%% Minidocumentation
% ExperimentData.nRepeats         = 2;
% ExperimentData.nTrials          = 2;
% ExperimentData.trials           = {};
% ExperimentData.startDelay       = 5;
% ExperimentData.interTrialDelay  = 3;
% ExperimentData.runMode          = 0;%no preload

% event = {};
% event.type = '';
% event.data = '';
% event.id   =  0;        %Identifies a specific sound. (used to stop it)
% event.time  =  0;       %max time for user input
% event.color =  0;       %color of text (or shapes?)
% event.bgcolor   = 0;    %color of text background (or shapes?)
% event.fontsize  = 0;
% event.question  = '';
% event.locationX = 0;
% event.locationY = 0;

% Trial types:
% rendering
%     drawImage   : Draws image on screen
%     show/clear  : Shows previously drawn stuff (if nothing is drawn, it shows black?)
%     drawText    : Draws text on screen
% audio
%     sound       : plays a sound
%     endSound    : ends sound (id)
%     endSoundAll : ends all sounds
%     pauseSound  : pauses sound (id)
%     resumeSound : resumes sound (id)
% time
%     delay       : waits x seconds (high precision)
%     getTimer    : saves time passed since the start of the trial in feedback
%     waitForKey  : waits for a keypress to occur before resuming
% userInput
%     inputText   : Draws string on screen and allows string input for x seconds
%     inputChar   : Draws string on screen and allows one character input for x seconds
%     inputNum    : Draws string on screen and allows a number input for x seconds