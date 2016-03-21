function varargout = ArrayBuilder(varargin)
% ARRAYBUILDER MATLAB code for ArrayBuilder.fig
%      ARRAYBUILDER, by itself, creates a new ARRAYBUILDER or raises the existing
%      singleton*.
%
%      H = ARRAYBUILDER returns the handle to a new ARRAYBUILDER or the handle to
%      the existing singleton*.
%
%      ARRAYBUILDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARRAYBUILDER.M with the given input arguments.
%
%      ARRAYBUILDER('Property','Value',...) creates a new ARRAYBUILDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ArrayBuilder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ArrayBuilder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ArrayBuilder

% Last Modified by GUIDE v2.5 17-Feb-2016 18:07:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ArrayBuilder_OpeningFcn, ...
                   'gui_OutputFcn',  @ArrayBuilder_OutputFcn, ...
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

global counter;
global X;
global Y;
global A;
counter = 1;


% --- Executes just before ArrayBuilder is made visible.
function ArrayBuilder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ArrayBuilder (see VARARGIN)

% Choose default command line output for ArrayBuilder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ArrayBuilder wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global direc;
direc = uipickfiles('Prompt', 'Select Config Destination', 'Output', 'cell');
if isempty(direc);
    direc = 'C:\Users\Brandon\Documents\MATLAB';
end
% 
% pas_image =  (imread('Mission Patch PAS.png'));
% axes(handles.axes2) 
% imagesc(pas_image);
% set(handles.axes2, 'HandleVisibility', 'off');






% --- Outputs from this function are returned to the command line.
function varargout = ArrayBuilder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in create_array.
function create_array_Callback(hObject, eventdata, handles)
% hObject    handle to create_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% =====================================================
% sets up RF parameters
% =====================================================
global X;
global Y;
global A;
global DX;
global DY;
global NUMX;
global NUMY;
%clear handles.UserData;
%testing%
% set(handles.enter_prop_speed, 'String', '300');
% set(handles.enter_op_freq, 'String', '400');
% %set(handles.enter_dx, 'String', '1');
% %set(handles.enter_dy, 'String', '1');
% set(handles.enter_numx, 'String', '11');
% set(handles.enter_numy, 'String', '11');


UserData.c = str2num(get(handles.enter_prop_speed, 'String'));
UserData.frequency = str2num(get(handles.enter_op_freq, 'String'));
UserData.lambda = (((UserData.c/UserData.frequency) * 100)/ 2.54);


% if (get(handles.lamb_over_two, 'Value')==1);
%     UserData.dx = UserData.lambda/2;
%     DX = UserData.dx;
%     UserData.dy = UserData.lambda/2;
%     DY = UserData.dy;
%     
% else 
%     UserData.dx = str2num(get(handles.enter_dx, 'String'));
%     UserData.dy = str2num(get(handles.enter_dy, 'String'));
%     
% end

UserData.dx = str2num(get(handles.enter_dx, 'String'));
UserData.dy = str2num(get(handles.enter_dy, 'String'));
% =====================================================
% Sets up the array
% =====================================================

UserData.num_elems_x = str2num(get(handles.enter_numx, 'String'));
UserData.num_elems_y = str2num(get(handles.enter_numy, 'String'));
NUMX = UserData.num_elems_x;
NUMY = UserData.num_elems_y;

length_x = (UserData.num_elems_x-1)*UserData.dx;
length_y = (UserData.num_elems_y-1)*UserData.dy;

x_pos = linspace(-length_x/2, length_x/2, UserData.num_elems_x);
y_pos = linspace(-length_y/2, length_y/2, UserData.num_elems_y);

% x and y coordinte of each element
%fprintf('Setting up array...');
[X,Y] = meshgrid(x_pos,y_pos);
%fprintf('Done\n\n');


% =====================================================
% Sets up the taper
% =====================================================
%fprintf('Setting up element taper...');
UserData.taper_flag = get(handles.taper_dropdown, 'Value');
clobber = ones(UserData.num_elems_y,UserData.num_elems_x);
clobber(:,:) = NaN;
set(handles.array_table, 'Data', clobber, 'ColumnWidth', {20});

if UserData.taper_flag == 1;
    UserData.A = ones(UserData.num_elems_y,UserData.num_elems_x);

elseif UserData.taper_flag == 2;
    x_taylor_weight = taylorwin(UserData.num_elems_x);
    y_taylor_weight = taylorwin(UserData.num_elems_y);

    [taylor_az, taylor_el] = meshgrid(x_taylor_weight,y_taylor_weight);
    UserData.A = taylor_az.*taylor_el;
    
elseif UserData.taper_flag == 3;
    x_tukey_weight = tukeywin(UserData.num_elems_x);
    y_tukey_weight = tukeywin(UserData.num_elems_y);
    [tukey_az, tukey_el] = meshgrid(x_tukey_weight,y_tukey_weight);
    UserData.A = tukey_az.*tukey_el;
    
% elseif UserData.taper_flag == 4;
%     UserData.A = randn(UserData.num_elems_x, UserData.num_elems_y);
%     
% elseif UserData.taper_flag == 5;
%     UserData.A = ones(UserData.num_elems_x,UserData.num_elems_y);
%     UserData.A = 100*A;
%     UserData.A(:,1:UserData.num_elems_x/2)=-10;

elseif UserData.taper_flag == 4;
    x_hamming_weight = hamming(UserData.num_elems_x);
    y_hamming_weight = hamming(UserData.num_elems_y);
    [hamming_az, hamming_el] = meshgrid(x_hamming_weight,y_hamming_weight);
    UserData.A = hamming_az.*hamming_el;
    
elseif UserData.taper_flag == 5;
    x_blackman_weight = blackman(UserData.num_elems_x);
    y_blackman_weight = blackman(UserData.num_elems_y);
    [blackman_az, blackman_el] = meshgrid(x_blackman_weight,y_blackman_weight);
    UserData.A = blackman_az.*blackman_el;
    
elseif UserData.taper_flag == 6;
    x_chebyshev_weight = chebwin(UserData.num_elems_x);
    y_chebyshev_weight = chebwin(UserData.num_elems_y);
    [chebyshev_az, chebyshev_el] = meshgrid(x_chebyshev_weight,y_chebyshev_weight);
    UserData.A = chebyshev_az.*chebyshev_el;
    
elseif UserData.taper_flag == 7;
    x_gaussian_weight = gausswin(UserData.num_elems_x);
    y_gaussian_weight = gausswin(UserData.num_elems_y);
    [gaussian_az, gaussian_el] = meshgrid(x_gaussian_weight,y_gaussian_weight);
    UserData.A = gaussian_az.*gaussian_el;
    
elseif UserData.taper_flag == 8;
    x_hann_weight = hann(UserData.num_elems_x);
    y_hann_weight = hann(UserData.num_elems_y);
    [hann_az, hann_el] = meshgrid(x_hann_weight,y_hann_weight);
    UserData.A = hann_az.*hann_el;
    
elseif UserData.taper_flag == 9;
    x_kaiser_weight = kaiser(UserData.num_elems_x);
    y_kaiser_weight = kaiser(UserData.num_elems_y);
    [kaiser_az, kaiser_el] = meshgrid(x_kaiser_weight,y_kaiser_weight);
    UserData.A = kaiser_az.*kaiser_el;
    
elseif UserData.taper_flag == 10;
    x_flattop_weight = flattopwin(UserData.num_elems_x);
    y_flattop_weight = flattopwin(UserData.num_elems_y);
    [flattop_az, flattop_el] = meshgrid(x_flattop_weight,y_flattop_weight);
    UserData.A = flattop_az.*flattop_el;
    
elseif UserData.taper_flag == 11;
    x_bohman_weight = bohmanwin(UserData.num_elems_x);
    y_bohman_weight = bohmanwin(UserData.num_elems_y);
    [bohman_az, bohman_el] = meshgrid(x_bohman_weight,y_bohman_weight);
    UserData.A = bohman_az.*bohman_el;
    
elseif UserData.taper_flag == 12;
    x_bartlethann_weight = barthannwin(UserData.num_elems_x);
    y_bartlethann_weight = barthannwin(UserData.num_elems_y);
    [bartlethann_az, bartlethann_el] = meshgrid(x_bartlethann_weight,y_bartlethann_weight);
    UserData.A = bartlethann_az.*bartlethann_el;
    
elseif UserData.taper_flag == 13;
    x_parzen_weight = parzenwin(UserData.num_elems_x);
    y_parzen_weight = parzenwin(UserData.num_elems_y);
    [parzen_az, parzen_el] = meshgrid(x_parzen_weight,y_parzen_weight);
    UserData.A = parzen_az.*parzen_el;
    
elseif UserData.taper_flag == 14;
    x_triangle_weight = triang(UserData.num_elems_x);
    y_triangle_weight = triang(UserData.num_elems_y);
    [triangle_az, triangle_el] = meshgrid(x_triangle_weight,y_triangle_weight);
    UserData.A = triangle_az.*triangle_el;
    
% elseif UserData.taper_flag == 5;
%     x__weight = (UserData.num_elems_x);
%     y__weight = (UserData.num_elems_y);
%     [_az, _el] = meshgrid(x__weight,y__weight);
%     UserData.A = _az.*_el;
    
    
end

A_temp = UserData.A;
size_A_temp = size(A_temp);
if (get(handles.radiobutton2, 'Value') == 1)
    A_temp(:,1:(size_A_temp(2)/2)) = -1*A_temp(:,1:(size_A_temp(2)/2));

elseif (get(handles.radiobutton3, 'Value') == 1)
    A_temp(1:(size_A_temp(1)/2),:) = -1*A_temp(1:(size_A_temp(1)/2),:);
end

UserData.A = A_temp;
A = A_temp;

%power_drop = 20*log10(A);
set(handles.array_table, 'Data', A, 'ColumnWidth', {50});
%fprintf('Done\n\n');


%imagesc(handles.array_plot,X,Y,A); 


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
global X;
global Y;
global direc;
global NUMX;
global NUMY;
global DX;
global DY;
final_el_mat = get(handles.array_table, 'Data');
UserData.c = str2num(get(handles.enter_prop_speed, 'String'));
UserData.frequency = str2num(get(handles.enter_op_freq, 'String'));
UserData.lambda = (((UserData.c/UserData.frequency) * 100)/ 2.54);
% direc = uipickfiles('Prompt', 'Select Folder', 'Output', 'cell');
%filename = inputdlg('Enter space-separated numbers:', 'Sample', [1 50]);
c = clock;
if ((length(mat2str(c(2))) == 1))
    buf1 = '0';
else
    buf1 = '';
end

if ((length(mat2str(c(3))) == 1))
    buf2 = '0';
else
    buf2 = '';
end

if ((length(mat2str(c(4))) == 1))
    buf3 = '0';
else
    buf3 = '';
end

if ((length(mat2str(c(5))) == 1))
    buf4 = '0';
else
    buf4 = '';
end

temp_str = c(6);
temp_str = num2str(temp_str);
split = strread(temp_str,'%s','delimiter','.');
left = str2mat(cellstr(split(1)));
right = str2mat(cellstr(split(2)));


if (length(left) == 0)
    buf5 = '00';
elseif (length(left) == 1)
    buf5 = '0';
else
    buf5 = '';
end

if (length(right) == 0)
    buf6 = '0000';
    
elseif (length(right) == 1)
    buf6 = '000';
    
    
elseif (length(right) == 2)
    buf6 = '00';
    
elseif (length(right) == 3)
    buf6 = '0';
    
else
    buf6 = '';
   
end

UserData.taper_flag = get(handles.taper_dropdown, 'Value');
if UserData.taper_flag == 1;
    taper_str = 'Uniform'
elseif UserData.taper_flag == 2;
    taper_str = 'Taylor'
elseif UserData.taper_flag == 3;
    taper_str = 'Tukey'
elseif UserData.taper_flag == 4;
    taper_str = 'Hamming'
elseif UserData.taper_flag == 5;
    taper_str = 'Blackman'
elseif UserData.taper_flag == 6;
    taper_str = 'Chebyshev'
elseif UserData.taper_flag == 7;
    taper_str = 'Gaussian'
elseif UserData.taper_flag == 8;
    taper_str = 'Hann'
elseif UserData.taper_flag == 9;
    taper_str = 'Kaiser'
elseif UserData.taper_flag == 10;
    taper_str = 'Flattop'
elseif UserData.taper_flag == 11;
    taper_str = 'Bohman'
elseif UserData.taper_flag == 12;
    taper_str = 'Bartlett-Hann'
elseif UserData.taper_flag == 13;
    taper_str = 'Parzen'
elseif UserData.taper_flag == 14;
    taper_str = 'Triangle'
% elseif UserData.taper_flag == 15;
%     taper_str = ''
end

if (get(handles.radiobutton2, 'Value') == 1)
    port_name = 'DAZ';

elseif (get(handles.radiobutton3, 'Value') == 1)
    port_name = 'DEL';
else
    port_name = 'SUM';
end



filename = [taper_str '_' port_name '_' buf1 mat2str(c(2)) '_' buf2 mat2str(c(3)) '_' mat2str(c(1)) '_' buf3 mat2str(c(4)) '_' buf4 mat2str(c(5)) '_' buf5 left right buf6];
%disp(filename);
file_str = sprintf('%s.xlsx',filename(:));


%disp(file_str);
full_file = fullfile(direc{:},file_str);
%disp(full_file);



xlswrite(full_file, final_el_mat,1);%'Amplitudes');
xlswrite(full_file, X, 2);%'X Coordinates');
xlswrite(full_file, Y, 3);%'Y Coordinates');
xlswrite(full_file, [UserData.lambda, UserData.c, UserData.frequency, NUMX, NUMY, DX, DY], 4);%'Parameters')

set(handles.text23, 'String', full_file);


% --- Executes on selection change in taper_dropdown.
function taper_dropdown_Callback(hObject, eventdata, handles)
% hObject    handle to taper_dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns taper_dropdown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from taper_dropdown


% --- Executes during object creation, after setting all properties.
function taper_dropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to taper_dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enter_numx_Callback(hObject, eventdata, handles)
% hObject    handle to enter_numx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enter_numx as text
%        str2double(get(hObject,'String')) returns contents of enter_numx as a double


% --- Executes during object creation, after setting all properties.
function enter_numx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enter_numx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enter_numy_Callback(hObject, eventdata, handles)
% hObject    handle to enter_numy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enter_numy as text
%        str2double(get(hObject,'String')) returns contents of enter_numy as a double


% --- Executes during object creation, after setting all properties.
function enter_numy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enter_numy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enter_op_freq_Callback(hObject, eventdata, handles)
% hObject    handle to enter_op_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enter_op_freq as text
%        str2double(get(hObject,'String')) returns contents of enter_op_freq as a double


% --- Executes during object creation, after setting all properties.
function enter_op_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enter_op_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enter_prop_speed_Callback(hObject, eventdata, handles)
% hObject    handle to enter_prop_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enter_prop_speed as text
%        str2double(get(hObject,'String')) returns contents of enter_prop_speed as a double


% --- Executes during object creation, after setting all properties.
function enter_prop_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enter_prop_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enter_dx_Callback(hObject, eventdata, handles)
% hObject    handle to enter_dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enter_dx as text
%        str2double(get(hObject,'String')) returns contents of enter_dx as a double


% --- Executes during object creation, after setting all properties.
function enter_dx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enter_dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enter_dy_Callback(hObject, eventdata, handles)
% hObject    handle to enter_dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enter_dy as text
%        str2double(get(hObject,'String')) returns contents of enter_dy as a double


% --- Executes during object creation, after setting all properties.
function enter_dy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enter_dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in lamb_over_two.
function lamb_over_two_Callback(hObject, eventdata, handles)
% hObject    handle to lamb_over_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lamb_over_two
% global counter;
% 
global DX;
global DY;
global TEMP_DX;
global TEMP_DY;

UserData.c = str2num(get(handles.enter_prop_speed, 'String'));
UserData.frequency = str2num(get(handles.enter_op_freq, 'String'));
UserData.lambda = (((UserData.c/UserData.frequency) * 100)/ 2.54);



UserData.dx = UserData.lambda/2;
DX = UserData.dx;
UserData.dy = UserData.lambda/2;
DY = UserData.dy;

if (get(handles.lamb_over_two,'Value') == 1);
    TEMP_DX = get(handles.enter_dx, 'String');
    TEMP_DY = get(handles.enter_dy, 'String');
    set(handles.enter_dx, 'String', DX);
    set(handles.enter_dy, 'String', DY);
    set(handles.enter_dx, 'Enable', 'off');
    set(handles.enter_dy, 'Enable', 'off');
    
else
    set(handles.enter_dx, 'String', TEMP_DX);
    set(handles.enter_dy, 'String', TEMP_DY);
    %set(handles.enter_dx, 'String', temp_dx);
    %set(handles.enter_dy, 'String', temp_dy);
    set(handles.enter_dx, 'Enable', 'on');
    set(handles.enter_dy, 'Enable', 'on');
end
% 
% counter = counter + 1;


% --- Executes on button press in plot_button.
function plot_button_Callback(hObject, eventdata, handles)
% hObject    handle to plot_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global X;
global Y;
final_el_mat = get(handles.array_table, 'Data');
%scat = scatter3(X,Y,final_el_mat);
C = repmat((min(final_el_mat):max(final_el_mat)),numel(X),1);
%scatter(X(:),Y(:),[],final_el_mat(:));
scatter(X(:),Y(:),[100],final_el_mat(:),'filled')
%caxis([0,max(final_el_mat(:))]);
view(2);

xlabel('X Layout (inches)');
ylabel('Y Layout (inches)');

title('Forward Looking Aft (FLA)')


% --- Executes on button press in run_dft.
function run_dft_Callback(hObject, eventdata, handles)
% hObject    handle to run_dft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global X;
global Y;
global A;

global span_U;
global span_V;
global U_cut;
global V_cut;

UserData.c = str2num(get(handles.enter_prop_speed, 'String'));
UserData.frequency = str2num(get(handles.enter_op_freq, 'String'));
UserData.lambda = (((UserData.c/UserData.frequency) * 100)/ 2.54);


El_Angle = get(handles.elsteer, 'Value');
Az_Angle = get(handles.azsteer, 'Value');
AzSteering = sind(El_Angle)*cosd(Az_Angle);
ElSteering = sind(El_Angle)*sind(Az_Angle);

fprintf('Done\n\n');
% =====================================================
% sets up the scan volume
% =====================================================
fprintf('Setting up scan volume...');
span_U = -1:.005:1;
span_V = -1:.005:1;

[U,V] = meshgrid(span_U,span_V);
fprintf('Done\n\n');
% =====================================================
% sets up the dft
% =====================================================

% for looping
array_size_x = size(X);
array_size_y = size(Y);

% gets number of rows and cols for iteration
num_rows = array_size_x(1);
num_cols = array_size_x(2);

pef = get(handles.edit15,'Value');
ef = (1 - U.^2 - V.^2).^(pef/4);

total_voltage = 0;

for row = 1:num_rows
    
    for col = 1:num_cols;
        %%fprintf('Comping element at X = %f, Y = %f...', col, row);
        %fprintf('row: %d, col: %d\n',row,col); 
        Az_prime = X(row,col)*AzSteering;
        El_prime = Y(row,col)*ElSteering;
        amp_volt = A(row,col)*exp(1i*((2*pi)/UserData.lambda)*(Az_prime + El_prime + X(row,col)*U + Y(row,col)*V));
        
        total_voltage = total_voltage + amp_volt;
        %%fprintf('Done\n*********************************************\n');
    end
end
total_voltage = total_voltage .* ef;


out_of_bounds = U.^2 + V.^2;
excl_FF_effect = find(out_of_bounds > 1);
total_voltage(excl_FF_effect) = NaN;


%total_voltage = awgn(abs(total_voltage),10);

% figure; 
% surf(U,V,(20*log10(abs(total_voltage)) - max(20*log10(abs(total_voltage)))));
% surf(x_pos, y_pos, A);

% dB_volt = 20*log10(abs(total_voltage));
% dB_plot = surf(span_U,span_V,dB_volt);
% set(dB_plot, 'LineStyle', 'none');
% contourf(span_U,span_V,dB_volt, 'LineStyle', 'none');

figure; 
%axes('LineWidth', 2, 'box', 'on');
imagesc(span_U,span_V,20*log10(abs(total_voltage)) - max(20*log10(abs(total_voltage(:)))));
caxis([-50 0]);

xlabel('U', 'FontSize', 18);
ylabel('V', 'FontSize', 18);
title('Far Field, U vs. V', 'FontSize', 18);



% figure;
% ffplot = surf(span_U,span_V,20*log10(abs(total_voltage))- max(20*log10(abs(total_voltage(:)))), 'LineStyle', 'none');
% xlabel('U', 'FontSize', 18);
% ylabel('V', 'FontSize', 18);
% zlabel('Amp [dB]');
% caxis([-50 0]);
% title('3D Beam in U and V vs. Amp', 'FontSize', 18);
% 
norm_amp = 20*log10(abs(total_voltage));

U_cut = norm_amp(200,:);
V_cut = norm_amp(:,200);

% size_amp = size(norm_amp);
% half_U = (size_amp(2) - mod(size_amp(2),2)) / 2;
% half_V = (size_amp(1) - mod(size_amp(1),2)) / 2;


% figure;
% plot(span_U, U_cut, 'LineWidth', 3, 'color', 'Black');
% ylim([-30 40]);
% xlabel('U (Azimuth)', 'FontSize', 18);
% ylabel('Amp [dB]', 'FontSize', 18);
% title('U Cut', 'FontSize', 18);
% figure;
% plot(span_V, V_cut, 'LineWidth', 3, 'color', 'Black');
% ylim([-30 40]);
% xlabel('V (Elevation)', 'FontSize', 18);
% ylabel('Amp [dB]', 'FontSize', 18);
% title('V Cut', 'FontSize', 18);




function azsteer_Callback(hObject, eventdata, handles)
% hObject    handle to azsteer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of azsteer as text
%        str2double(get(hObject,'String')) returns contents of azsteer as a double


% --- Executes during object creation, after setting all properties.
function azsteer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to azsteer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elsteer_Callback(hObject, eventdata, handles)
% hObject    handle to elsteer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elsteer as text
%        str2double(get(hObject,'String')) returns contents of elsteer as a double


% --- Executes during object creation, after setting all properties.
function elsteer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elsteer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in closefigs.
function closefigs_Callback(hObject, eventdata, handles)
% hObject    handle to closefigs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1, 'HandleVisibility', 'off');
close all;
set(handles.figure1, 'HandleVisibility', 'on');



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cut_button.
function cut_button_Callback(hObject, eventdata, handles)
% hObject    handle to cut_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global span_U;
global span_V;
global U_cut;
global V_cut;

figure;
plot(span_U, U_cut, 'LineWidth', 3, 'color', 'Black');
ylim([-30 40]);
xlabel('U (Azimuth)', 'FontSize', 18);
ylabel('Amp [dB]', 'FontSize', 18);
title('U Cut', 'FontSize', 18);
figure;
plot(span_V, V_cut, 'LineWidth', 3, 'color', 'Black');
ylim([-30 40]);
xlabel('V (Elevation)', 'FontSize', 18);
ylabel('Amp [dB]', 'FontSize', 18);
title('V Cut', 'FontSize', 18);
