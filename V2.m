function varargout = V2(varargin)
% V2 M-file for V2.fig
%      V2, by itself, creates a new V2 or raises the existing
%      singleton*.
%
%      H = V2 returns the handle to a new V2 or the handle to
%      the existing singleton*.
%
%      V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in V2.M with the given input arguments.
%
%      V2('Property','Value',...) creates a new V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before V2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to V2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help V2

% Last Modified by GUIDE v2.5 24-Jan-2017 12:27:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @V2_OpeningFcn, ...
                   'gui_OutputFcn',  @V2_OutputFcn, ...
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


% --- Executes just before V2 is made visible.
function V2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to V2 (see VARARGIN)

% Choose default command line output for V2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handles = guidata(hObject);


% UIWAIT makes V2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = V2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in PopupTemp1.
function PopupTemp1_Callback(hObject, eventdata, handles)
% hObject    handle to PopupTemp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupTemp1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupTemp1
guidata(hObject, handles)
% mit diesem Befehl wird der Wert aus der Auswahl ausgelesen
contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
value = contents{get(hObject,'Value')};
VAL = cellstr(value);
%
% ?bernehmen der Daten vom Auslesen der Daten
A = handles.A;
TXT = handles.TXT;
RAW = handles.RAW;

% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(VAL, TXT));
% Um einen zur?cksetzen, um auf die Matrix A auszurichten
Index = Index - 1;

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(time,A(2:end,Index))
xlabel('time');
ylabel('Temperatur in K');
grid on 
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt



% --- Executes during object creation, after setting all properties.
function PopupTemp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupTemp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopUpDruck1.
function PopUpDruck1_Callback(hObject, eventdata, handles)
% hObject    handle to PopUpDruck1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopUpDruck1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopUpDruck1

guidata(hObject, handles)

contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
value = contents{get(hObject,'Value')};
VAL = cellstr(value);
%
% ?bernehmen der Daten vom Auslesen der Daten
A = handles.A;
TXT = handles.TXT;
RAW = handles.RAW;

% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(VAL, TXT));
% Um einen zur?cksetzen, um auf die Matrix A auszurichten
Index = Index - 1;

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(time,A(2:end,Index))
xlabel('time');
ylabel('Druck in bara');
grid on 
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt




% --- Executes during object creation, after setting all properties.
function PopUpDruck1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopUpDruck1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopUpFlow1.
function PopUpFlow1_Callback(hObject, eventdata, handles)
% hObject    handle to PopUpFlow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns PopUpFlow1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopUpFlow1
contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
value = contents{get(hObject,'Value')};
VAL = cellstr(value);
%
% ?bernehmen der Daten vom Auslesen der Daten
A = handles.A;
TXT = handles.TXT;
RAW = handles.RAW;

% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(VAL, TXT));
% Um einen zur?cksetzen, um auf die Matrix A auszurichten
Index = Index - 1;

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(time,A(2:end,Index))
xlabel('time');
ylabel('Durchfluss');
grid on 
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt




% --- Executes during object creation, after setting all properties.
function PopUpFlow1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopUpFlow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopUpLevel1.
function PopUpLevel1_Callback(hObject, eventdata, handles)
% hObject    handle to PopUpLevel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopUpLevel1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopUpLevel1

guidata(hObject, handles)
contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
value = contents{get(hObject,'Value')};
VAL = cellstr(value);
%
% ?bernehmen der Daten vom Auslesen der Daten
A = handles.A;
TXT = handles.TXT;
RAW = handles.RAW;

% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(VAL, TXT));
% Um einen zur?cksetzen, um auf die Matrix A auszurichten
Index = Index - 1;

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(time,A(2:end,Index))
xlabel('time');
ylabel('Fuellstandlevel in %');
grid on 
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt




% --- Executes during object creation, after setting all properties.
function PopUpLevel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopUpLevel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
%% Hier werden Daten aus der Excel Datei ausgelesen
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Die handles werden aktualisiert
handles = guidata(hObject);
filename = uigetfile({'*.xls'},'Open Excel Sheet'); % Festlegen des Namens
[type,sheetname] = xlsfinfo(filename); %Abfragen der Informationen ueber das Excel File
sheet = sheetname{2}; % Welche Bl?tter sollen eingelesen werden? Hier muss der Name des Blattes stehen und nicht die Nummer oder so.
guidata(hObject, handles);
[A,TXT,RAW]=xlsread(filename,sheet); % Einlesen der Daten. Numeric ist die Matrix mit den Werten, TXT ist die Matrix mit dem Header und Raw der ganze rest nochmal zusammen
A = snip(A,nan); % Herausschneiden der nicht geschriebenen Werte
% Es wird nur die erste Zeile benutzt
TXT = TXT (1,:);
% Die gelesenen Matrizen werden in die function handles geschrieben
handles.A = A;
handles.TXT = TXT;
handles.RAW = RAW;
% ... und aktualisiert
guidata(hObject, handles)

%% Hier muss noch hin, was passiert, wenn man nix ausw?hlt.
