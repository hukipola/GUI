function varargout = guiversion1_190117(varargin)
% GUIVERSION1_190117 MATLAB code for guiversion1_190117.fig
%      GUIVERSION1_190117, by itself, creates a new GUIVERSION1_190117 or raises the existing
%      singleton*.
%
%      H = GUIVERSION1_190117 returns the handle to a new GUIVERSION1_190117 or the handle to
%      the existing singleton*.
%
%      GUIVERSION1_190117('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIVERSION1_190117.M with the given input arguments.
%
%      GUIVERSION1_190117('Property','Value',...) creates a new GUIVERSION1_190117 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiversion1_190117_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiversion1_190117_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiversion1_190117

% Last Modified by GUIDE v2.5 19-Jan-2017 13:46:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiversion1_190117_OpeningFcn, ...
                   'gui_OutputFcn',  @guiversion1_190117_OutputFcn, ...
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


% --- Executes just before guiversion1_190117 is made visible.
function guiversion1_190117_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiversion1_190117 (see VARARGIN)

% Choose default command line output for guiversion1_190117
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% set(hObject,'UserData',s)


% UIWAIT makes guiversion1_190117 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiversion1_190117_OutputFcn(hObject, eventdata, handles) 
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
val =get(hObject,'Value');
str = get(hObject,'String'); %returns popupmenu1 contents as cell array
%  switch str{val}
%      case 'T1'
%          fprintf('T1'); 
%      case 'T2'
%          fprintf('T2')
%      case 'T3'
%         fprintf('T3')
%  end
 
%  contents{get(hObject,'Value')} %returns selected item from popupmenu1


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
s = {'text','den','ich','teste'};
guidata(hObject, handles);
% s = handles.data;
set(hObject,'String',s);
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
filename = uigetfile({'*.xls'},'Open Excel Sheet'); % Festlegen des Namens
[type,sheetname] = xlsfinfo(filename); %Abfragen der Informationen ueber das Excel File
sheet = sheetname{2}; % Welche Bl?tter sollen eingelesen werden? Hier muss der Name des Blattes stehen und nicht die Nummer oder so.
guidata(hObject, handles);
[A,TXT,RAW]=xlsread(filename,sheet); % Einlesen der Daten. Numeric ist die Matrix mit den Werten, TXT ist die Matrix mit dem Header und Raw der ganze rest nochmal zusammen
A = snip(A,nan); % Herausschneiden der nicht geschriebenen Werte
handles.data = {'text','den','ich','teste'};
