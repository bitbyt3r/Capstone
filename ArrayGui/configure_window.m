function varargout = configure_window(varargin)
% CONFIGURE_WINDOW MATLAB code for configure_window.fig
%      CONFIGURE_WINDOW, by itself, creates a new CONFIGURE_WINDOW or raises the existing
%      singleton*.
%
%      H = CONFIGURE_WINDOW returns the handle to a new CONFIGURE_WINDOW or the handle to
%      the existing singleton*.
%
%      CONFIGURE_WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIGURE_WINDOW.M with the given input arguments.
%
%      CONFIGURE_WINDOW('Property','Value',...) creates a new CONFIGURE_WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before configure_window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to configure_window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help configure_window

% Last Modified by GUIDE v2.5 24-Feb-2016 20:21:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @configure_window_OpeningFcn, ...
                   'gui_OutputFcn',  @configure_window_OutputFcn, ...
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


% --- Executes just before configure_window is made visible.
function configure_window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to configure_window (see VARARGIN)

% Choose default command line output for configure_window
handles.output = hObject;
global root;
%global azNum ;
%global elNum ;
%global session;
%global volt_range;
%global messagestring;
set(handles.az,'String',root.configuration.numElementsX);
set(handles.el,'String',root.configuration.numElementsY);
set(handles.session_rate,'String',root.configuration.session);
set(handles.voltage_text,'String',root.configuration.volt_range);
root.configuration.messagestring = [];




guidata(hObject, handles);

% UIWAIT makes configure_window wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = configure_window_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function el_Callback(hObject, eventdata, handles)
% hObject    handle to el (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of el as text
%        str2double(get(hObject,'String')) returns contents of el as a double


% --- Executes during object creation, after setting all properties.
function el_CreateFcn(hObject, eventdata, handles)
% hObject    handle to el (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in configure_device_button.
function configure_device_button_Callback(hObject, eventdata, handles)
% hObject    handle to configure_device_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global azNum;
%global elNum;
%global appdata;
%setappdata(handles.configure_window,'azNum', str2double(get(handles.az,'String')));
%setappdata(handles.configure_window,'azNum', str2double(get(handles.az,'String')));
% azNum = str2double(get(handles.az,'String'));
% elNum = str2double(get(handles.el,'String'));
% % setappdata(hObject,'azNum',str2double(get(handles.az,'String')))
% % setappdata(hObject,'elNum',str2double(get(handles.el,'String')))



global root;
%global elNum;
%global session;
%global volt_range;
%global messagestring;
root.configuration.numElementsX = str2double(get(handles.az,'String'));
root.configuration.numElementsY = str2double(get(handles.el,'String'));

root.configuration.session = str2double(get(handles.session_rate,'String'));
root.configuration.volt_range = str2double(get(handles.voltage_text,'String'));
 disp(root.configuration.numElementsX);
 disp(root.configuration.numElementsY);
 disp(root.configuration.session);
 disp(root.configuration.volt_range);
 
 
 setup(root.configuration.numElementsX, root.configuration.numElementsY, root.configuration.session, root.configuration.volt_range);
 disp(root.configuration.s);
 %root.configuration.messagestring = [root.configuration.messagestring;message];
 %set (handles.list_configs,'String',root.configuration.messagestring);
 %%set (handles.list_configs,'String','hi');
 
 


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function az_Callback(hObject, eventdata, handles)
% hObject    handle to az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of az as text
%        str2double(get(hObject,'String')) returns contents of az as a double


% --- Executes during object creation, after setting all properties.
function az_CreateFcn(hObject, eventdata, handles)
% hObject    handle to az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in list_configs.
function list_configs_Callback(hObject, eventdata, handles)
% hObject    handle to list_configs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_configs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_configs


% --- Executes during object creation, after setting all properties.
function list_configs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_configs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% 
% function setAzimuth(hObject,num)
% handles = guidata(hObject);
% handles.azNum = num;
% guidata(hObject,handles);


% --- Executes on button press in clear_console.
function clear_console_Callback(hObject, eventdata, handles)
% hObject    handle to clear_console (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global root;
root.configuration.messagestring = [];
%global azNum;
%global elNum;
%global session;
%global volt_range;


root.configuration.numElementsX = 0;
root.configuration.numElementsY = 0;
root.configuration.session = 0;
root.configuration.volt_range = 0;
 
 set (handles.list_configs,'String',root.configuration.messagestring);
  set (handles.az,'String',0);
   set (handles.el,'String',0);
    set (handles.session_rate,'String',0);
     set (handles.voltage_text,'String',0);

function session_rate_Callback(hObject, eventdata, handles)
% hObject    handle to session_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of session_rate as text
%        str2double(get(hObject,'String')) returns contents of session_rate as a double


% --- Executes during object creation, after setting all properties.
function session_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to session_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function voltage_text_Callback(hObject, eventdata, handles)
% hObject    handle to voltage_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voltage_text as text
%        str2double(get(hObject,'String')) returns contents of voltage_text as a double


% --- Executes during object creation, after setting all properties.
function voltage_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltage_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
