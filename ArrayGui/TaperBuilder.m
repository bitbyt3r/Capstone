function varargout = TaperBuilder(varargin)
% TAPERBUILDER MATLAB code for TaperBuilder.fig
%      TAPERBUILDER, by itself, creates a new TAPERBUILDER or raises the existing
%      singleton*.
%
%      H = TAPERBUILDER returns the handle to a new TAPERBUILDER or the handle to
%      the existing singleton*.
%
%      TAPERBUILDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAPERBUILDER.M with the given input arguments.
%
%      TAPERBUILDER('Property','Value',...) creates a new TAPERBUILDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TaperBuilder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TaperBuilder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TaperBuilder

% Last Modified by GUIDE v2.5 24-Feb-2016 21:03:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TaperBuilder_OpeningFcn, ...
                   'gui_OutputFcn',  @TaperBuilder_OutputFcn, ...
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


% --- Executes just before TaperBuilder is made visible.
function TaperBuilder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TaperBuilder (see VARARGIN)

% Choose default command line output for TaperBuilder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TaperBuilder wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global root;

% --- Outputs from this function are returned to the command line.
function varargout = TaperBuilder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

global root;
root.configuration.numElementsX = 8;
root.configuration.numElementsY = 8;
num_elems_x = root.configuration.numElementsX;
num_elems_y = root.configuration.numElementsY;
%%root.taper;


% =====================================================
% Sets up the taper
% =====================================================
%fprintf('Setting up element taper...');
taper_selection = get(handles.popupmenu1, 'Value');

if taper_selection == 1;
    root.taper.amplitude_mesh = ones(num_elems_y,num_elems_x);

elseif taper_selection == 2;
    x_taylor_weight = taylorwin(num_elems_x);
    y_taylor_weight = taylorwin(num_elems_y);

    [taylor_az, taylor_el] = meshgrid(x_taylor_weight,y_taylor_weight);
    root.taper.amplitude_mesh = taylor_az.*taylor_el;
    
elseif taper_selection == 3;
    x_tukey_weight = tukeywin(num_elems_x);
    y_tukey_weight = tukeywin(num_elems_y);
    [tukey_az, tukey_el] = meshgrid(x_tukey_weight,y_tukey_weight);
    root.taper.amplitude_mesh = tukey_az.*tukey_el;

elseif taper_selection == 4;
    x_hamming_weight = hamming(num_elems_x);
    y_hamming_weight = hamming(num_elems_y);
    [hamming_az, hamming_el] = meshgrid(x_hamming_weight,y_hamming_weight);
    root.taper.amplitude_mesh = hamming_az.*hamming_el;
    
elseif taper_selection == 5;
    x_blackman_weight = blackman(num_elems_x);
    y_blackman_weight = blackman(num_elems_y);
    [blackman_az, blackman_el] = meshgrid(x_blackman_weight,y_blackman_weight);
    root.taper.amplitude_mesh = blackman_az.*blackman_el;
    
elseif taper_selection == 6;
    x_chebyshev_weight = chebwin(num_elems_x);
    y_chebyshev_weight = chebwin(num_elems_y);
    [chebyshev_az, chebyshev_el] = meshgrid(x_chebyshev_weight,y_chebyshev_weight);
    root.taper.amplitude_mesh = chebyshev_az.*chebyshev_el;
    
elseif taper_selection == 7;
    x_gaussian_weight = gausswin(num_elems_x);
    y_gaussian_weight = gausswin(num_elems_y);
    [gaussian_az, gaussian_el] = meshgrid(x_gaussian_weight,y_gaussian_weight);
    root.taper.amplitude_mesh = gaussian_az.*gaussian_el;
    
elseif taper_selection == 8;
    x_hann_weight = hann(num_elems_x);
    y_hann_weight = hann(num_elems_y);
    [hann_az, hann_el] = meshgrid(x_hann_weight,y_hann_weight);
    root.taper.amplitude_mesh = hann_az.*hann_el;
    
elseif taper_selection == 9;
    x_kaiser_weight = kaiser(num_elems_x);
    y_kaiser_weight = kaiser(num_elems_y);
    [kaiser_az, kaiser_el] = meshgrid(x_kaiser_weight,y_kaiser_weight);
    root.taper.amplitude_mesh = kaiser_az.*kaiser_el;
    
elseif taper_selection == 10;
    x_flattop_weight = flattopwin(num_elems_x);
    y_flattop_weight = flattopwin(num_elems_y);
    [flattop_az, flattop_el] = meshgrid(x_flattop_weight,y_flattop_weight);
    root.taper.amplitude_mesh = flattop_az.*flattop_el;
    
elseif taper_selection == 11;
    x_bohman_weight = bohmanwin(num_elems_x);
    y_bohman_weight = bohmanwin(num_elems_y);
    [bohman_az, bohman_el] = meshgrid(x_bohman_weight,y_bohman_weight);
    root.taper.amplitude_mesh = bohman_az.*bohman_el;
    
elseif taper_selection == 12;
    x_bartlethann_weight = barthannwin(num_elems_x);
    y_bartlethann_weight = barthannwin(num_elems_y);
    [bartlethann_az, bartlethann_el] = meshgrid(x_bartlethann_weight,y_bartlethann_weight);
    root.taper.amplitude_mesh = bartlethann_az.*bartlethann_el;
    
elseif taper_selection == 13;
    x_parzen_weight = parzenwin(num_elems_x);
    y_parzen_weight = parzenwin(num_elems_y);
    [parzen_az, parzen_el] = meshgrid(x_parzen_weight,y_parzen_weight);
    root.taper.amplitude_mesh = parzen_az.*parzen_el;
    
elseif taper_selection == 14;
    x_triangle_weight = triang(num_elems_x);
    y_triangle_weight = triang(num_elems_y);
    [triangle_az, triangle_el] = meshgrid(x_triangle_weight,y_triangle_weight);
    root.taper.amplitude_mesh = triangle_az.*triangle_el;


end

set(handles.uitable1, 'Data', root.taper.amplitude_mesh, 'ColumnWidth', {50});
root.taper.amplitude_vector = root.taper.amplitude_mesh(:)';

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
