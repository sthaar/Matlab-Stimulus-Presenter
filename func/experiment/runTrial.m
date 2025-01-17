%     Copyright (C) 2016  Erwin Diepgrond
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
% 0Template note:
%   \ means insert
% things you can insert:
%   load => Loading script
%   run => running script
%   runload => Run & load script
% format of insertion
%   if event.name == 'eventName'
%       Things done
%   end
%   repeat..
function [ replyData ] = runTrial( events, windowPtr, mode )
% RUNTRIAL Runs the trial according to TrialData and returns Inputdata from
% the subject (or monkey)
%   It needs the handle to the window created by initWindowBlack or
%   initWindowWhite;
%   Mode will be the way the experiment is done.
%   Not yet implemented

%% Speed experiment findings
% A if argument will slow down by >0.001 ms
% using strcmpi instead of integers or floats is NOT slower:
% 1.6703e-05 for 8 compare if's with t==5
% 1.6895e-05 for 8 compare if's with strcmp
% Timing is the same for both (the sd will be something like 0.01e-05)
% Considering this, starting a timer in a loop and in the next iteration
% give a stimuli and the Next iteration get the timer will only add 1ms of
% computation (given that the simuli is loaded in the loop on a SSD)
% This might not be the best, therefore a timing solution loop will be
% made.

%% The kind of loops that are,  will be or should be implementented.
% First off, the the 0 mode called default mode.
% Everything works as expected but there are significant delays in timings.
% This mode can be used when the stimuli are movies (30sec+), when the interval
% between stimuli and timing of the reaction is of no importance.
% Do not use when you want things like (image - 2ms - image) or (image -
% 0ms - sound). It just wont do. 
%% Argument checks and presets
switch(nargin)
    case 2
        mode = 0;
    case 3
        % All is Ok!
    otherwise
        error('incorrect usage of runTrial...');
end

%% initialisation
data = {};
nEvents = length(events); % the amount of events (show image, present sound, delay etc)
audioHandles = zeros(1,40);
replyData = cell(1,nEvents);

%% Trial Loops
switch mode
    %% no preload
    case 0
        replyIter = 1;
        eventIter = 1;
        startTime = GetSecs();
        while eventIter <= nEvents
            % Craete data
            event = events{eventIter};
            reply = struct;
            reply.name = event.name;
            eventName = event.name;
            reply.timeEventStart = GetSecs() - startTime;
            % Run event
% generated script "Load sound dataset" from LoadSoundDataset.m
if strcmp(eventName,'Load sound dataset')
if ~exist('SoundDataset', 'var')
 SoundDataset = struct;
end
eval(sprintf('[SoundDataset.%s.Sounds SoundDataset.%s.Files] = loadSoundDatasetSounds(event.datasetname);',event.datasetname, event.datasetname));
eval(sprintf('SoundDataset.%s.ids=1:length(SoundDataset.%s.Sounds);',event.datasetname, event.datasetname));


end
% generated script "Play dataset sound" from PlaySoundDataset.m
if strcmp(eventName,'Play dataset sound')
if event.random
    event.soundID = eval(sprintf('SoundDataset.%s.ids(randi(length(SoundDataset.%s.ids)));', event.datasetname, event.datasetname));
end
if ~event.putBack
    eval(sprintf('SoundDataset.%s.ids(SoundDataset.%s.ids==event.soundID)= [];', event.datasetname, event.datasetname));
end
event.sHandle = eval(sprintf('SoundDataset.%s.Sounds{event.soundID};', event.datasetname));

reply.soundStartTime = PsychPortAudio('Start', event.sHandle, event.repetitions, 0 , event.waitForStart , event.stopTime , 0);
reply.soundID = event.soundID;


end
% generated script "Show Image" from showImage.m
if strcmp(eventName,'Show Image')
event.im = imread(event.data);
Screen('PutImage', windowPtr, event.im);
Screen('Flip', windowPtr, event.delay, double(~event.clear));
reply.data = event.data;
end
% generated script "Wait" from wait.m
if strcmp(eventName,'Wait')

WaitSecs(event.time);
reply.waittime = event.time;
end
% generated script "Repeat x events" from flowEvent_repeat.m
if strcmp(eventName,'Repeat x events')


end
            % Save
            reply.timeEventEnd = GetSecs() - startTime;
            reply.blockname = event.blockname;
            replyData{replyIter} = reply;
            % Iter
            replyIter = replyIter + 1;
            eventIter = eventIter + 1;
        end
    %% preload  
    case 1
        for i=1:nEvents % load
            event = events{i};
            eventName = event.name;
% generated script "Load sound dataset" from LoadSoundDataset.m
if strcmp(eventName,'Load sound dataset')
if ~exist('SoundDataset', 'var')
 SoundDataset = struct;
end
eval(sprintf('[SoundDataset.%s.Sounds SoundDataset.%s.Files] = loadSoundDatasetSounds(event.datasetname);',event.datasetname, event.datasetname));
eval(sprintf('SoundDataset.%s.ids=1:length(SoundDataset.%s.Sounds);',event.datasetname, event.datasetname));

end
% generated script "Play dataset sound" from PlaySoundDataset.m
if strcmp(eventName,'Play dataset sound')
if event.random
    event.soundID = eval(sprintf('SoundDataset.%s.ids(randi(length(SoundDataset.%s.ids)));', event.datasetname, event.datasetname));
end
if ~event.putBack
    eval(sprintf('SoundDataset.%s.ids(SoundDataset.%s.ids==event.soundID)= [];', event.datasetname, event.datasetname));
end
event.sHandle = eval(sprintf('SoundDataset.%s.Sounds{event.soundID};', event.datasetname));

end
% generated script "Show Image" from showImage.m
if strcmp(eventName,'Show Image')
event.im = imread(event.data);
end
% event Wait has no load function. (wait)
% event Repeat x events has no load function. (flowEvent_repeat)
            events{i} = event; % save event data (that is loaded for the run fun)
        end
        replyIter = 1;
        eventIter = 1;
        startTime = GetSecs();
        while eventIter <= nEvents % run
            event = events{eventIter};
            % Create data
            reply = struct;
            reply.name = event.name;
            eventName = event.name;
            reply.timeEventStart = GetSecs() - startTime;
            % Run event
% generated script "Load sound dataset" from LoadSoundDataset.m
if strcmp(eventName,'Load sound dataset')

end
% generated script "Play dataset sound" from PlaySoundDataset.m
if strcmp(eventName,'Play dataset sound')
reply.soundStartTime = PsychPortAudio('Start', event.sHandle, event.repetitions, 0 , event.waitForStart , event.stopTime , 0);
reply.soundID = event.soundID;


end
% generated script "Show Image" from showImage.m
if strcmp(eventName,'Show Image')
Screen('PutImage', windowPtr, event.im);
Screen('Flip', windowPtr, event.delay, double(~event.clear));
reply.data = event.data;
end
% generated script "Wait" from wait.m
if strcmp(eventName,'Wait')
WaitSecs(event.time);
reply.waittime = event.time;
end
% generated script "Repeat x events" from flowEvent_repeat.m
if strcmp(eventName,'Repeat x events')

end
            % Save data
            reply.timeEventEnd = GetSecs() - startTime;
            reply.blockname = event.blockname;
            if isfield(event, 'alias')
                reply.alias = event.alias;
            end
            replyData{replyIter} = reply;
            events{eventIter} = event; % save event data (that is loaded for the run fun)
            % Iters
            replyIter = replyIter + 1;
            eventIter = eventIter + 1;
        end
    otherwise
        error('Unknown trial run mode')
end

%% Clean audio handles
for i=1:length(audioHandles)
    if ~(audioHandles(i)==0)
        PsychPortAudio('Close' , audioHandles(i));
    end
end

%% finish data compile
% nothing to do here
end

