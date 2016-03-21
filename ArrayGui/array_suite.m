function varargout = array_suite(varargin)
% ARRAY_SUITE MATLAB code for array_suite.fig
%      ARRAY_SUITE, by itself, creates a new ARRAY_SUITE or raises the existing
%      singleton*.
%
%      H = ARRAY_SUITE returns the handle to a new ARRAY_SUITE or the handle to
%      the existing singleton*.
%
%      ARRAY_SUITE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARRAY_SUITE.M with the given input arguments.
%
%      ARRAY_SUITE('Property','Value',...) creates a new ARRAY_SUITE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before array_suite_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to array_suite_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help array_suite

% Last Modified by GUIDE v2.5 25-Feb-2016 12:06:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @array_suite_OpeningFcn, ...
                   'gui_OutputFcn',  @array_suite_OutputFcn, ...
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


% --- Executes just before array_suite is made visible.
function array_suite_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to array_suite (see VARARGIN)

% Choose default command line output for array_suite
handles.output = hObject;


global root;

root.configuration.numElementsX = 0;
root.configuration.numElementsY = 0;
root.configuration.session = 0;
root.configuration.volt_range = 0;

root.suite.az_span = 0;
root.suite.el_span = 0;
root.suite.az_step = 0;
root.suite.el_step = 0;

root.suite.console_data = [];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes array_suite wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = array_suite_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function device_config_button_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to device__panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global root
    %root.configuration.s;
    configure_window;
    
% --------------------------------------------------------------------
function array_builder_button_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to array_builder_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ArrayBuilder;
   
% --------------------------------------------------------------------
function acquire_button_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to acquire_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in scan_console.
function scan_console_Callback(hObject, eventdata, handles)
% hObject    handle to scan_console (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scan_console contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scan_console


% --- Executes during object creation, after setting all properties.
function scan_console_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scan_console (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clear_console.
function clear_console_Callback(hObject, eventdata, handles)
% hObject    handle to clear_console (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function az_min_Callback(hObject, eventdata, handles)
% hObject    handle to az_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of az_min as text
%        str2double(get(hObject,'String')) returns contents of az_min as a double



% --- Executes during object creation, after setting all properties.
function az_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to az_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function el_max_Callback(hObject, eventdata, handles)
% hObject    handle to el_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of el_max as text
%        str2double(get(hObject,'String')) returns contents of el_max as a double


% --- Executes during object creation, after setting all properties.
function el_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to el_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function az_step_Callback(hObject, eventdata, handles)
% hObject    handle to az_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of az_step as text
%        str2double(get(hObject,'String')) returns contents of az_step as a double


% --- Executes during object creation, after setting all properties.
function az_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to az_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function el_step_Callback(hObject, eventdata, handles)
% hObject    handle to el_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of el_step as text
%        str2double(get(hObject,'String')) returns contents of el_step as a double


% --- Executes during object creation, after setting all properties.
function el_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to el_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in amp_scan.
function amp_scan_Callback(hObject, eventdata, handles)
% hObject    handle to amp_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp_scan


% --- Executes on button press in freq_scan.
function freq_scan_Callback(hObject, eventdata, handles)
% hObject    handle to freq_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of freq_scan


% --- Executes on button press in phase_scan.
function phase_scan_Callback(hObject, eventdata, handles)
% hObject    handle to phase_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of phase_scan


% --- Executes on button press in scan_button.
function scan_button_Callback(hObject, eventdata, handles)
% hObject    handle to scan_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global root

root.suite.az_min = str2double(get(handles.az_min,'String'));
root.suite.az_max = str2double(get(handles.az_max,'String'));
root.suite.el_min = str2double(get(handles.el_max,'String'));
root.suite.el_max = str2double(get(handles.el_min,'String'));

root.suite.az_step = str2double(get(handles.az_step,'String'));
root.suite.el_step = str2double(get(handles.el_step,'String'));


%get the duration
if (get(handles.single_scan_radio_button,'Value')==1)
    root.suite.scan_time = str2double(get(handles.duration,'String'));

else
    root.suite.scan_time = .25;
    

end

[root.suite.data,root.suite.scan_time] = acquire_data(root.suite.scan_time); %gets the data from the NI device, apply a taper, or a filter.  


%apply taper
if(get(handles.taper_on_off,'Value') == 1)
   root.suite.data = Apply_Taper(root.suite.data, root.taper.amplitude_vector ); 
end

%apply filter
if(get(handles.filter_on_off, 'Value') == 1)
    root.suite.data = Apply_Filter(root.suite.data);% must add filter functionality; 
end
if(get(handles.amp_scan,'Value')==1)
    button_choice = 1;
elseif (get(handles.freq_scan,'Value')==1)
    button_choice = 2;
else
    button_choice = 3;
end
disp('got here before');
[root.suite.plot_data,X,Y, message ] = scanFunction(root.suite.data, root.suite.az_min, root.suite.az_max, root.suite.el_min, root.suite.el_max, root.suite.az_step, root.suite.el_step,root.configuration.numElementsX, root.configuration.numElementsY,button_choice );%this kicks off the scan
%save('data_to_plot.mat','plot_data');

disp('got here after');

imagesc(X,Y,20*log10(root.suite.plot_data));

root.suite.console_data = [root.suite.console_data; message];
root.suite.console_data = [root.suite.console_data; root.suite.plot_data];
set(handles.scan_console,'String',root.suite.console_data);


%get frequency
root.suite.target_freq = str2double(get(handles.find_frequency,'String'));
if(get(handles.amp_scan,'Value')==1)
    [root.suite.target.amplitude.az,root.suite.target.amplitude.el,root.suite.target.amplitude.max_value] = Target_Match_Amplitude(root.suite.az_min,root.suite.el_max,root.suite.az_step, root.suite.el_step, root.suite.plot_data);
elseif (get(handles.freq_scan,'Value')==1)
    [root.suite.target.frequency.az,root.suite.target.frequency.el,root.suite.target.frequency.closest_value] = Target_Match_Frequency(root.suite.target_freq, root.suite.el_min,root.suite.az_max,root.suite.az_step, root.suite.el_step, root.suite.plot_data);
   
else
end


%plot the data



% --- Executes on button press in beam_config_button.
function beam_config_button_Callback(hObject, eventdata, handles)
% hObject    handle to beam_config_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TaperBuilder;

% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel21 is resized.
function uipanel21_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel17 is resized.
function uipanel17_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel18 is resized.
function uipanel18_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel19 is resized.
function uipanel19_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function duration_Callback(hObject, eventdata, handles)
% hObject    handle to duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duration as text
%        str2double(get(hObject,'String')) returns contents of duration as a double


% --- Executes during object creation, after setting all properties.
function duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in coefficient_button.
function coefficient_button_Callback(hObject, eventdata, handles)
% hObject    handle to coefficient_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in coefficient_button.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to coefficient_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function az_max_Callback(hObject, eventdata, handles)
% hObject    handle to az_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of az_max as text
%        str2double(get(hObject,'String')) returns contents of az_max as a double


% --- Executes during object creation, after setting all properties.
function az_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to az_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function el_min_Callback(hObject, eventdata, handles)
% hObject    handle to el_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of el_min as text
%        str2double(get(hObject,'String')) returns contents of el_min as a double


% --- Executes during object creation, after setting all properties.
function el_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to el_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_on_off.
function filter_on_off_Callback(hObject, eventdata, handles)
% hObject    handle to filter_on_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filter_on_off


% --- Executes on button press in taper_on_off.
function taper_on_off_Callback(hObject, eventdata, handles)
% hObject    handle to taper_on_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of taper_on_off



function find_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to find_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of find_frequency as text
%        str2double(get(hObject,'String')) returns contents of find_frequency as a double


% --- Executes during object creation, after setting all properties.
function find_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to find_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
