function varargout = ExperimentBlockEditor(varargin)
% EXPERIMENTBLOCKEDITOR MATLAB code for ExperimentBlockEditor.fig
%      EXPERIMENTBLOCKEDITOR, by itself, creates a new EXPERIMENTBLOCKEDITOR or raises the existing
%      singleton*.
%
%      H = EXPERIMENTBLOCKEDITOR returns the handle to a new EXPERIMENTBLOCKEDITOR or the handle to
%      the existing singleton*.
%
%      EXPERIMENTBLOCKEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENTBLOCKEDITOR.M with the given input arguments.
%
%      EXPERIMENTBLOCKEDITOR('Property','Value',...) creates a new EXPERIMENTBLOCKEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ExperimentBlockEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ExperimentBlockEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ExperimentBlockEditor

% Last Modified by GUIDE v2.5 30-Mar-2016 14:52:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ExperimentBlockEditor_OpeningFcn, ...
    'gui_OutputFcn',  @ExperimentBlockEditor_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ExperimentBlockEditor is made visible.
function ExperimentBlockEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ExperimentBlockEditor (see VARARGIN)

% Choose default command line output for ExperimentBlockEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%% Checks
if nargin ~= 4
    delete(handles.figure1);
    error('Invalid usage for experimentBlockEditor(blockStruct)');
end

blockData = varargin{1};
if ~isstruct(blockData)
    error('Invalid usage: Input must be a struct!');
end

%% Handle input
if ~isfield(blockData,'name') || ~isfield(blockData, 'events')
    warning('Missing fields in struct: name OR events');
    if ~isfield(blockData,'name')
        blockData.name = 'TheMostRandomNameEver';
    end
    if ~isfield(blockData, 'events')
        blockData.events = {};
    end
end

handles.blockData = blockData;
guidata(handles.figure1, handles);

% Update GUI
guiUpdate(handles);

% UIWAIT makes ExperimentBlockEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function guiUpdate(handles)
handles.listboxtitle.String = sprintf('Event list: %s', handles.blockData.name);
% Update listbox
listboxdata = {};
if ~isempty(handles.blockData.events)
    for e=handles.blockData.events
        event = e{1};
        if sum(strcmp('alias',fieldnames(event))) == 1
            listboxdata = [listboxdata; {[event.name ': ' event.alias]}];
        else
            listboxdata = [listboxdata; {event.name}];
        end
    end
end
handles.eventList.String = listboxdata;

% Check listbox value does not exceed the # items
if handles.eventList.Value > length(handles.eventList.String)
    handles.eventList.Value = 1;
end

% Update eventSelectorMenu
[eventNames,eventFiles,eventDir, eventMap ] = getEvents();
handles.eventSelectorMenu.String = eventNames;
infoStr = '';
% Check current selected item in listbox (not the dropdown)
% And set the informationText
if ~isempty(handles.eventList.String) && ~isempty(handles.blockData.events)
    idx = handles.eventList.Value;
    event = handles.blockData.events{idx};
    items = fieldnames(event);
    for fn = 1:length(items)
        fname = items{fn};
        infoLine = 0;
        if ~strcmp(fname,'name')
            data = eval(sprintf('event.%s',fname));
            if isnumeric(data)
                infoLine = sprintf('%s:\t%s',fname,num2str(data));
            elseif islogical(data)
                if data
                    infoLine = sprintf('%s:\t%s',fname,'True');
                else
                    infoLine = sprintf('%s:\t%s',fname,'False');
                end
            elseif isstr(data)
                infoLine = sprintf('%s:\t%s',fname,data);
            else
                %Ignore
            end
            infoStr = sprintf('%s\n%s',infoStr,infoLine);
        end
        
    end
    infoStr = sprintf('Name:\t%s%s',event.name,infoStr);
end
infoStr = sprintf('Information:\n\n%s',infoStr);
handles.informationText.String = infoStr;


% --- Outputs from this function are returned to the command line.
function varargout = ExperimentBlockEditor_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in eventList.
function eventList_Callback(hObject, eventdata, handles)
% hObject    handle to eventList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns eventList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from eventList
guiUpdate(handles);

% --- Executes during object creation, after setting all properties.
function eventList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eventList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in eventSelectorMenu.
function eventSelectorMenu_Callback(hObject, eventdata, handles)
% hObject    handle to eventSelectorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns eventSelectorMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from eventSelectorMenu


% --- Executes during object creation, after setting all properties.
function eventSelectorMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eventSelectorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonAddEvent.
function buttonAddEvent_Callback(hObject, eventdata, handles)
% hObject    handle to buttonAddEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[~,~,eventDir, eventMap ] = getEvents();
if ~isempty(handles.eventSelectorMenu.String)
    eventname = handles.eventSelectorMenu.String{handles.eventSelectorMenu.Value};
    eventfilef = fullfile(eventDir,[eventMap(eventname) '.m']);
    eventfile = eventMap(eventname);
    if ~exist(eventfilef,'file')
        waitfor(errordlg('Error: Event could not be found! Make sure you didn''t change the Current Directory!'));
        return
    end
    % global eventEditorFeedback
    prevpath = addpath(eventDir);
    try
        questStruct = eval(sprintf('%s(''getQuestStruct'')',eventfile));
        if isstruct(questStruct)
            type = eval(sprintf('%s(''dataType'')',eventfile));
            if ~strcmp(type,'')
                % Data is requested!
                l = length(questStruct);
                datasets = getDatasets();
                if isempty(datasets)
                    error('No dataset avaible! Please create one before using this event!');
%                     questStruct(l+1).name = 'Dataset settings:';
%                     questStruct(l+1).sort = 'text';
%                     questStruct(l+1).data = 'No datasets available';
                else
                    %What dataset?
                    questStruct(l+1).name = 'Choose Dataset:';
                    questStruct(l+1).sort = 'popupmenu';
                    questStruct(l+1).data = datasets;
                    %Random?
                    questStruct(l+2).name = 'Random selection?';
                    questStruct(l+2).sort = 'popupmenu';
                    questStruct(l+2).data = {'No', 'Yes'};
                    %put back?
                    questStruct(l+3).name = 'Put back?';
                    questStruct(l+3).sort = 'popupmenu';
                    questStruct(l+3).data = {'No', 'Yes'};
                    questStruct(l+3).toolTip = 'In dutch, one would say: Met terugleggen. Meaning stimuli can be selected more than once';
                end
            end
            if ~isempty(fieldnames(questStruct))
                waitfor(questionDialog(questStruct));
                global eventEditorFeedback
                if isstruct(eventEditorFeedback);
                    answers = eventEditorFeedback;
                    % We got our answers. Use the add answer stuff
                    if ~strcmp(type,'')
                        % Data is requested!
                        dataset = answers(l+1).answer;
                        random = answers(l+2).Value;
                        putBack = answers(l+3).Value;
                    end
                    eventStruct = eval(sprintf('%s(''getEventStruct'',answers)',eventfile));
                    if ~strcmp(type,'')
                        eventStruct.dataset = dataset;
                        eventStruct.randomData = random-1;
                        eventStruct.putBack = putBack-1;
                    end
                    % event.name = the name given by event('getName')
                    % event.alias is displayed if it exist
                    eventStruct.name = eval(sprintf('%s(''getName'')',eventfile));
                    index = length(handles.blockData.events) + 1;
                    handles.blockData.events{index} = eventStruct;
                end
            end
        else
            warining('%s gave an invalid thing for getQuestStruct', eventname);
        end
        
    catch e
        waitfor(errordlg(sprintf('Error while evaluating answers: %s',e.message)));
        path(prevpath);
        rethrow(e);
    end
    path(prevpath);
end
guidata(handles.figure1, handles);
guiUpdate(handles);


% --- Executes on button press in buttonRemoveSelected.
function buttonRemoveSelected_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRemoveSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.eventList.String)
    return
end
handles.blockData.events(handles.eventList.Value) = [];
guidata(handles.figure1, handles);
guiUpdate(handles);

% --- Executes on button press in buttonDuplicateSelected.
function buttonDuplicateSelected_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDuplicateSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.eventList.String)
    return
end
event = handles.blockData.events(handles.eventList.Value);
handles.blockData.events = [handles.blockData.events event];
guidata(handles.figure1, handles);
guiUpdate(handles);

% --- Executes on button press in buttonEditSelected.
function buttonEditSelected_Callback(hObject, eventdata, handles)
% hObject    handle to buttonEditSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in buttonUp.
function buttonUp_Callback(hObject, eventdata, handles)
% hObject    handle to buttonUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loc = handles.eventList.Value;
if loc==1 %Already in top
    return
end
selected = handles.blockData.events{handles.eventList.Value};
res = handles.blockData.events;
res(loc) = [];
newOrder = [res(1:loc-2) {selected} res(loc-1:end)];
handles.blockData.events = newOrder;
handles.eventList.Value = handles.eventList.Value - 1;
guidata(handles.figure1, handles);
guiUpdate(handles);


% --- Executes on button press in buttonDown.
function buttonDown_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loc = handles.eventList.Value;
if loc==length(handles.eventList.String) %Already in top
    return
end
selected = handles.blockData.events{handles.eventList.Value};
res = handles.blockData.events;
res(loc) = [];
newOrder = [res(1:loc) {selected} res(loc+1:end)];
handles.blockData.events = newOrder;
handles.eventList.Value = handles.eventList.Value +1;
guidata(handles.figure1, handles);
guiUpdate(handles);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global experimentlbockeditorreturnvalue
experimentlbockeditorreturnvalue = handles.blockData;
delete(hObject);
