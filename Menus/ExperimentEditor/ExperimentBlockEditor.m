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

% Last Modified by GUIDE v2.5 05-Mar-2016 16:50:32

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

%% Read folder content and update event list

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ExperimentBlockEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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


% --- Executes on button press in addEvent.
function addEvent_Callback(hObject, eventdata, handles)
% hObject    handle to addEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in removeSelected.
function removeSelected_Callback(hObject, eventdata, handles)
% hObject    handle to removeSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in duplicateSelected.
function duplicateSelected_Callback(hObject, eventdata, handles)
% hObject    handle to duplicateSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in editSelected.
function editSelected_Callback(hObject, eventdata, handles)
% hObject    handle to editSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SaveAndClose.
function SaveAndClose_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAndClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% Functions
function refresh
%% Refreshes the lists and dropdowns
end
