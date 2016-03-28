function varargout = ExperimentEditor(varargin)
% EXPERIMENTEDITOR MATLAB code for ExperimentEditor.fig
%      EXPERIMENTEDITOR, by itself, creates a new EXPERIMENTEDITOR or raises the existing
%      singleton*.
%
%      H = EXPERIMENTEDITOR returns the handle to a new EXPERIMENTEDITOR or the handle to
%      the existing singleton*.
%
%      EXPERIMENTEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENTEDITOR.M with the given input arguments.
%
%      EXPERIMENTEDITOR('Property','Value',...) creates a new EXPERIMENTEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ExperimentEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ExperimentEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ExperimentEditor

% Last Modified by GUIDE v2.5 13-Jan-2016 18:12:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ExperimentEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @ExperimentEditor_OutputFcn, ...
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


% --- Executes just before ExperimentEditor is made visible.
function ExperimentEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ExperimentEditor (see VARARGIN)

% Choose default command line output for ExperimentEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ExperimentEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ExperimentEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in blockList.
function blockList_Callback(hObject, eventdata, handles)
% hObject    handle to blockList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns blockList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from blockList


% --- Executes during object creation, after setting all properties.
function blockList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blockList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in newTrial.
function newTrial_Callback(hObject, eventdata, handles)
% hObject    handle to newTrial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in addExisting.
function addExisting_Callback(hObject, eventdata, handles)
% hObject    handle to addExisting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in removeBlock.
function removeBlock_Callback(hObject, eventdata, handles)
% hObject    handle to removeBlock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
