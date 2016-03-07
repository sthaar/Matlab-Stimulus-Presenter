function [ handle ] = initWindowBlack(Message,priority,hideCursor )
%initWindowBlack Create the window and returns it handle
% initWindowBlack([Message][,priority = 2][,hideCursor = 1])
% String Message: a message to be displayed after creating the window
% As not to worry the user
%%%
% Priority, changes priority of the script. (0 = normal, 1 = high, 2 = max
% (realtime))

%Black screen
screenColor = [0 0 0];

n = nargin;
switch n
    case 2
        hideCursor = true;
    case 1
        priority = 2;
        hideCursor = true;
    case 0
        priority = 2;
        Message = 'Welcome to this experiment!';
        hideCursor = true;
end

screens = Screen('Screens');
%Get the screen we want
%If external exists, we want the primary screen. For reasons
screenNumber = min(screens);
handle = Screen('OpenWindow',screenNumber,screenColor);

%Hide cursor
if hideCursor
    HideCursor;
end

%Set epic priority for epic timings
Priority(2);

%Set text settings
Screen('TextFont',handle, 'Courier New');
Screen('TextSize',handle, 14);
Screen('TextStyle', handle, 1+2);


%Draw (welcome) message in the middle, white
DrawFormattedText(handle,Message,'center','center',[255 255 255 255]);

%Add a extra disclamer
DrawFormattedText(handle,'You can quit this experiment at any time using shift + 2 (@)\nPress anykey to start this experiment',...
    'center',0,[255 0 0 255]);

%flip the screen (to show the text)
Screen('Flip',handle);

KbPressWait(-1);
Screen('Flip',handle);
end

