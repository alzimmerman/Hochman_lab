function varargout = mygui(varargin)
% MYGUI M-file for mygui.fig
% Gui compares current clamp data across multiple cells.  Choose a file from the dropdown menu to plot f-I or original trace for.     

% MYGUI, by itself, creates a new MYGUI or raises the existing
%      singleton*.
%
%      H = MYGUI returns the handle to a new MYGUI or the handle to
%      the existing singleton*.
%
%      MYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGUI.M with the given input arguments.
%
%      MYGUI('Property','Value',...) creates a new MYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mygui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mygui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified by GUIDE v2.5 07-May-2008 13:39:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mygui_OpeningFcn, ...
                   'gui_OutputFcn',  @mygui_OutputFcn, ...
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

% --- Executes just before mygui is made visible.
function mygui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mygui (see VARARGIN)

% Loads initial data as specified in start_files
[files,injection,groups]=start_files;
handles.files=files;
handles.injection=injection;
handles.groups=groups;
[handles.R,C]=size(files);
maxnum=0;

for i=1:handles.R
     maxnum=max(maxnum,length(files{i,:}));
end

handles.Rm=zeros(maxnum,handles.R);
handles.Cm=zeros(maxnum,handles.R);
handles.fI_slope=zeros(maxnum, handles.R);
   
for i=1:handles.R
    %[cell,meanparams,average,standard_deviation]=compile_current(files(i,:),injection(i,:));
    [cell,meanparams]=compile_current(files{i,:},injection{i,:});
    eval(['handles.cell',num2str(i),'=cell;'])
    eval(['handles.meanparams',num2str(i),'=meanparams;']);
    
   [r,c]=size(meanparams);
   
   for j=1:r
        handles.Rm(j,i)=cell{9,:,j}(4);
        handles.Cm(j,i)=cell{10,:,j}(4);
        handles.fI_slope(j,i)=cell{11,:,j};
   end

   if r<maxnum
       meanparams=[meanparams;NaN.*ones((maxnum-r),5)];
       handles.Rm((r+1):maxnum,i)=NaN;
       handles.Cm((r+1):maxnum,i)=NaN;
       handles.fI_slope((r+1):maxnum,i)=NaN;
   end
   
    handles.Vth(:,i)=meanparams(:,1);
    handles.amp(:,i)=meanparams(:,2);
    handles.dur(:,i)=meanparams(:,3);
    handles.AHPmag(:,i)=meanparams(:,4);
    handles.AHPdur(:,i)=meanparams(:,5);
    
end

%plots mean properties
axes(handles.Vth_plot); boxplot(handles.Vth,'labels',handles.groups);
title('Threshhold Voltage'); ylabel('Voltage (mV)')

axes(handles.amp_plot); boxplot(handles.amp,'labels',handles.groups);
title('AP Amplitude'); ylabel('Voltage (mV)');

axes(handles.dur_plot); boxplot(handles.dur,'labels',handles.groups);
title('AP Duration'); ylabel('Duration (s)');

axes(handles.AHPmag_plot);boxplot(handles.AHPmag,'labels',handles.groups);
title('AHP Magnitude'); ylabel('Voltage (mV)');

axes(handles.AHPdur_plot); boxplot(handles.AHPdur,'labels',handles.groups);
title('AHP Duration'); ylabel('Duration (s)');

axes(handles.Rm_plot); boxplot(handles.Rm./(10^6),'labels',handles.groups);  
title('Membrane Resistance'); ylabel('Rm (M-ohms)');

axes(handles.Cm_plot); boxplot(handles.Cm.*(10^12),'labels',handles.groups);
title('Membrane Capacitance'); ylabel('Cm (pFs)');

axes(handles.fI_slope_plot); boxplot(handles.fI_slope,'labels',handles.groups);
title('fI Slope'); ylabel('fI slope (Hz/pA)');

% sets current data for fI and raw data plots as initial file
handles.freq=handles.cell1{7,:,1};
handles.current=handles.cell1{8,:,1};
handles.filenumber=1;
axes(handles.fI_plot);
handles.leg=files{1,1}(1);
plot(handles.freq,handles.current,'-*'); xlabel('Current (pA)'); ylabel('Frequency'); hold all; handles.L=legend(handles.leg);
title('F-I relationship'); set(handles.L,'Location','SouthEast');
axes(handles.rawdata_plot); handles.C=plotcurr(handles.cell1{1,:,1},injection{1,1}(1)); 
set(handles.C,'Location','SouthEast');
handles.plot=1; %default is to clear plots between chosing
handles.dataset_number=1;


% Choose default command line output for mygui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mygui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mygui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on selection change in file_popup.
function file_popup_Callback(hObject, eventdata, handles)
% hObject    handle to file_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns file_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_popup
val=get(hObject,'Value');
eval(['handles.freq=handles.cell',num2str(handles.dataset_number),'{7,:,val};']);
eval(['handles.k=handles.cell',num2str(handles.dataset_number),'{13,:,val};'])
eval(['handles.current=handles.cell',num2str(handles.dataset_number),'{8,:,val}{handles.k);']);
handles.filenumber=val;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function file_popup_CreateFcn(hObject, eventdata, handles)
% Sets file_popup to set 1 initially
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

[files,injection]=start_files;
set(hObject,'String',files{1,:});

% --- Executes on button press in plotbutton.
function plotbutton_Callback(hObject, eventdata, handles)
axes(handles.rawdata_plot); hold off; 
handles.C=plotcurr(handles.files{handles.dataset_number,1}{handles.filenumber},handles.injection{handles.dataset_number,1}(handles.filenumber));
set(handles.C,'Location','SouthEast');
if handles.plot==1
    axes(handles.fI_plot); hold off; plot(handles.current,handles.freq,'*-');
    handles.leg=handles.files{handles.dataset_number,1}{handles.filenumber};
else
    axes(handles.fI_plot); hold all; plot(handles.current,handles.freq,'*-')
    handles.leg=[handles.leg, handles.files{handles.dataset_number,1}(handles.filenumber)];
end
axes(handles.fI_plot); xlabel('Current (pA)'); ylabel('Frequency'); 
handles.L=legend(handles.leg); set(handles.L,'Location','SouthEast')
title('F-I relationship');

guidata(hObject, handles);

% --- Executes on button press in toggle1.
function toggle1_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of toggle1
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
	% Toggle button is pressed-take approperiate action
    handles.plot=0;
elseif button_state == get(hObject,'Min')
    handles.plot=1;
end

guidata(hObject, handles);

%------CREATE FUNCTIONS, MAY NOT BE NECESSARY --------------------%
% --- Executes during object creation, after setting all properties.
function rawdata_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rawdata_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function fI_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fI_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function Vth_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vth_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function amp_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function dur_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dur_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function AHPmag_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AHPmag_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function AHPdur_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AHPdur_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on selection change in dataset_popup.
function dataset_popup_Callback(hObject, eventdata, handles)
% hObject    handle to dataset_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dataset_number=get(hObject,'Value');
set(handles.file_popup,'String',handles.files{handles.dataset_number,1});
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dataset_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataset_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

[files,injection]=start_files;
[R,C]=size(files);
for i=1:R
    dataset(i)={int2str(i)};
end
set(hObject,'String',dataset)

% --- Executes on button press in zoom.
function zoom_Callback(hObject, eventdata, handles)
% hObject    handle to zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
	% Toggle button is pressed-take approperiate action
    zoom(handles.rawdata_plot,'on');
elseif button_state == get(hObject,'Min')
    zoom(handles.rawdata_plot,'off');
end



% --- Executes during object creation, after setting all properties.
function fI_slope_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fI_slope_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate fI_slope_plot


