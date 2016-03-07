function varargout = EventEditor(varargin)
% EVENTEDITOR MATLAB code for EventEditor.fig
%      EVENTEDITOR, by itself, creates a new EVENTEDITOR or raises the existing
%      singleton*.
%
%      H = EVENTEDITOR returns the handle to a new EVENTEDITOR or the handle to
%      the existing singleton*.
%
%      EVENTEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EVENTEDITOR.M with the given input arguments.
%
%      EVENTEDITOR('Property','Value',...) creates a new EVENTEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EventEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EventEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EventEditor

% Last Modified by GUIDE v2.5 06-Jan-2016 10:41:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EventEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @EventEditor_OutputFcn, ...
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


% --- Executes just before EventEditor is made visible.
function EventEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EventEditor (see VARARGIN)

%event initialization
handles.eventTypeText('String',eventdata.eventName);
% Choose default command line output for EventEditor
%handles.output = hObject;
handles.output = handles;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EventEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EventEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in saveAndClose.
function saveAndClose_Callback(hObject, eventdata, handles)
% hObject    handle to saveAndClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Combine Data
h = handles;
%Basic data
event = struct();
event.name = h.eventName.String;
event.type = h.eventTypeText.String;
%audio/video info
event.id = str2double(h.audioVisualID.String);
%Event struct for engine
% event = {};
% event.type = '';
% event.data = '';
% event.id   =  0;        %Identifies a specific sound. (used to stop it)
% event.time  =  0;       %max time for user input (blocking only)
% event.color =  0;       %color of text (or shapes?)
% event.bgcolor   = 0;    %color of text background (or shapes?)
% event.fontsize  = 0;
% event.question  = '';
% event.locationX = 0;
% event.locationY = 0;


% --- Executes on button press in Discard.
function Discard_Callback(hObject, eventdata, handles)
% hObject    handle to Discard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in dataSetPopupmenu.
function dataSetPopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to dataSetPopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dataSetPopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dataSetPopupmenu


% --- Executes during object creation, after setting all properties.
function dataSetPopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataSetPopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function seedInput_Callback(hObject, eventdata, handles)
% hObject    handle to seedInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seedInput as text
%        str2double(get(hObject,'String')) returns contents of seedInput as a double


% --- Executes during object creation, after setting all properties.
function seedInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seedInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on selection change in SyncDatasetChoice.
function SyncDatasetChoice_Callback(hObject, eventdata, handles)
% hObject    handle to SyncDatasetChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SyncDatasetChoice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SyncDatasetChoice


% --- Executes during object creation, after setting all properties.
function SyncDatasetChoice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SyncDatasetChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eventName_Callback(hObject, eventdata, handles)
% hObject    handle to eventName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eventName as text
%        str2double(get(hObject,'String')) returns contents of eventName as a double


% --- Executes during object creation, after setting all properties.
function eventName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eventName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime as text
%        str2double(get(hObject,'String')) returns contents of SleepTime as a double


% --- Executes during object creation, after setting all properties.
function SleepTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in roundNumbersCheckbox.
function roundNumbersCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to roundNumbersCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of roundNumbersCheckbox



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
