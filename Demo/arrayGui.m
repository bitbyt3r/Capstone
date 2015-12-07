function varargout = arrayGui(varargin)
% ARRAYGUI MATLAB code for arrayGui.fig
%      ARRAYGUI, by itself, creates a new ARRAYGUI or raises the existing
%      singleton*.
%
%      H = ARRAYGUI returns the handle to a new ARRAYGUI or the handle to
%      the existing singleton*.
%
%      ARRAYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARRAYGUI.M with the given input arguments.
%
%      ARRAYGUI('Property','Value',...) creates a new ARRAYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before arrayGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to arrayGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help arrayGui

% Last Modified by GUIDE v2.5 07-Dec-2015 02:08:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @arrayGui_OpeningFcn, ...
                   'gui_OutputFcn',  @arrayGui_OutputFcn, ...
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


% --- Executes just before arrayGui is made visible.
function arrayGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to arrayGui (see VARARGIN)

% Choose default command line output for arrayGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes arrayGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = arrayGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device;
global devicefound;
device = daq.getDevices;
if (size(device)==0)
    set(handles.deviceText,'String','unsuccessful connection');
    devicefound = 0;
else
    deviceStr = sprintf('%s - %s  %s', device.Vendor, device.ID, device.Model);
    set(handles.deviceText,'String',deviceStr);
    devicefound = 1;
end



function sessionRate_Callback(hObject, eventdata, handles)
% hObject    handle to sessionRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sessionRate as text
%        str2double(get(hObject,'String')) returns contents of sessionRate as a double



% --- Executes during object creation, after setting all properties.
function sessionRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numChannels_Callback(hObject, eventdata, handles)
% hObject    handle to numChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numChannels as text
%        str2double(get(hObject,'String')) returns contents of numChannels as a double



% --- Executes during object creation, after setting all properties.
function numChannels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startSession.
function startSession_Callback(hObject, eventdata, handles)
% hObject    handle to startSession (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)'
global rate;
global channelnum;
global devicefound;
global s;

rate = str2double(get(handles.sessionRate, 'string'));

channelnum = str2double(get(handles.numChannels,'string'));
if (isnan(channelnum)|isnan(rate)|(devicefound==0))
    set(handles.indicator,'BackgroundColor','r');

else


    set(handles.indicator,'BackgroundColor','g');
    s = daq.createSession(device.Vendor.ID);
   % set(handles.channelTable,'Columns',{'microphone','channel'});
    %channeladd();
    for i = 0 
    
end

%columnformat = {'numeric','numeric','numeric',{'Enabled' 'disabled'}};
%d = {5 5 5 'disabled'};
%columnEditable = [false, false,false, true];
%set(handles.channelTable,'Data', d, 'ColumnName',{'microphone','channel',
%    'location','enabled'},'ColumnFormat', columnformat,'ColumnEditable', columnEditable);

% --- Executes during object creation, after setting all properties.
function indicator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to indicator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when entered data in editable cell(s) in channelTable.
function channelTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to channelTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
