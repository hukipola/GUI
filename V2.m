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

% Last Modified by GUIDE v2.5 26-Jan-2017 12:22:12

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
handles = guidata(hObject);
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
axes(handles.axes1);
if handles.peins == 0
    hold on
else
    cla(handles.axes1)
end

hold on; 
plot(handles.axes1,time,A(2:end,Index))
legend(VAL);
xlabel('time');
ylabel('Temperatur in K');
grid on 
% Setzen der Plotvariable auf 'T'
handles.peins = 0;
guidata(hObject, handles)
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


% --- Executes on selection change in PopupDruck1.
function PopupDruck1_Callback(hObject, eventdata, handles)
% hObject    handle to PopupDruck1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupDruck1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupDruck1

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
axes(handles.axes2);

if handles.peins == 0
    hold on;
else
    cla(handles.axes1)
end

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 

plot(handles.axes2,time,A(2:end,Index))
legend(VAL);
xlabel('time');
ylabel('Druck in bara');
grid on 
handles.peins = 0;
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt




% --- Executes during object creation, after setting all properties.
function PopupDruck1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupDruck1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupFlow1.
function PopupFlow1_Callback(hObject, eventdata, handles)
% hObject    handle to PopupFlow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns PopupFlow1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupFlow1
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
axes(handles.axes1);
if handles.peins == 1
    hold on
else
    cla(handles.axes1)
end

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(handles.axes1,time,A(2:end,Index))
legend(VAL);
xlabel('time');
ylabel('Durchfluss');
grid on 
handles.peins = 1;
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt




% --- Executes during object creation, after setting all properties.
function PopupFlow1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupFlow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupLevel1.
function PopupLevel1_Callback(hObject, eventdata, handles)
% hObject    handle to PopupLevel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupLevel1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupLevel1

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
axes(handles.axes2);
if handles.pzwei == 2
    hold on
else
    cla(handles.axes2)
end

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(time,A(2:end,Index))
legend(VAL);
xlabel('time');
ylabel('Fuellstandlevel in %');
grid on 
handles.pzwei = 2;
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt




% --- Executes during object creation, after setting all properties.
function PopupLevel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupLevel1 (see GCBO)
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
if filename == 0
    set(handles.PopupTemp1,'String',{'text','den','ich','teste'});
    handles = guidata(hObject);
    return
else
    [type,sheetname] = xlsfinfo(filename); %Abfragen der Informationen ueber das Excel File
    sheet = sheetname{2}; % Welche Bl?tter sollen eingelesen werden? Hier muss der Name des Blattes stehen und nicht die Nummer oder so.
    guidata(hObject, handles);
    [A,TXT,RAW]=xlsread(filename,sheet); % Einlesen der Daten. Numeric ist die Matrix mit den Werten, TXT ist die Matrix mit dem Header und Raw der ganze rest nochmal zusammen
    A = snip(A,nan); % Herausschneiden der nicht geschriebenen Werte
    % Es wird nur die erste Zeile benutzt
    TXT = TXT (1,:);
    % Die gelesenen Matrizen werden in die function handles geschrieben
    handles.A = A;
    TXT = TXT(1,:);
    handles.TXT = TXT;
    handles.RAW = RAW;
    
    handles.pzwei = 'blau';
    handles.peins = 'rot';
    %% Benennung der PopUpMenues:
    % Wie heisst das erste Element von Temp?
    guidata(hObject, handles);
    temp_element1 = 'TR11_A_IN';
    druck_element1 = 'PIR11_bar_ABS';
    flow_element1 = 'FIR11_LH';
    level_element1 = 'LR11_PROZENT';
    string_ende = 'LRC61_PROZENT';
    %Finden der Position im TXT Vektor
    tempnumber1 = find(strcmp(temp_element1, handles.TXT));
    drucknumber1 = find(strcmp(druck_element1, handles.TXT));
    flownumber1 = find(strcmp(flow_element1, handles.TXT));
    levelnumber1 = find(strcmp(level_element1, handles.TXT));
    value_ende = find(strcmp(string_ende, handles.TXT));
    %Schreiben eines Vektors der die Namen enth?lt und an erster Stelle den
    %Werte '-select- hat.
    tempnames = handles.TXT(tempnumber1:drucknumber1-1);
    drucknames = handles.TXT(drucknumber1:flownumber1-1);
    flownames = handles.TXT(flownumber1:levelnumber1-1);
    levelnames = handles.TXT(levelnumber1:value_ende);
    tempnames{end+1} = '-Select-';
    drucknames{end+1} = '-Select-';
    flownames{end+1} = '-Select-';
    levelnames{end+1} = '-Select-';
    % Setzen der Werte f?r die Popupmenues
    %Temperatur Menues
    set(handles.PopupTemp1,'String',tempnames);
    set(handles.PopupTemp1,'Value',numel(tempnames));
    set(handles.PopupTemp2,'String',tempnames);
    set(handles.PopupTemp2,'Value',numel(tempnames));
    %DruckMenues
    set(handles.PopupDruck1,'String',drucknames);
    set(handles.PopupDruck1,'Value',numel(drucknames));
    set(handles.PopupDruck2,'String',drucknames);
    set(handles.PopupDruck2,'Value',numel(drucknames));
    %Flow Menues
    set(handles.PopupFlow1,'String',flownames);
    set(handles.PopupFlow1,'Value',numel(flownames));
    set(handles.PopupFlow2,'String',flownames);
    set(handles.PopupFlow2,'Value',numel(flownames));
    %Level Menues
    set(handles.PopupLevel1,'String',levelnames);
    set(handles.PopupLevel1,'Value',numel(levelnames));
    set(handles.PopupLevel2,'String',levelnames);
    set(handles.PopupLevel2,'Value',numel(levelnames));
    
    % Setzen der plo1 und plot2 Variablen, um ein doppeltes Plotten zu
    % verhindern
    guidata(hObject, handles);

    
    handles = guidata(hObject);
    guidata(hObject, handles)
end
% ... und aktualisiert
guidata(hObject, handles)


%% Hier muss noch hin, was passiert, wenn man nix auswaehlt.


% --- Executes on selection change in PopupTemp2.
function PopupTemp2_Callback(hObject, eventdata, handles)
% hObject    handle to PopupTemp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupTemp2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupTemp2
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
axes(handles.axes1);
disp(handles.peins);
if handles.peins == 0
    hold on;
else
    cla(handles.axes1)
end

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(handles.axes1,time,A(2:end,Index))
legend(VAL);
xlabel('time');
ylabel('Temperatur in K');
grid on 
%% 0 heisst Temperatur; 1 heisst Durchfluss
handles.peins = 0;
guidata(hObject, handles);
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt



% --- Executes during object creation, after setting all properties.
function PopupTemp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupTemp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupDruck2.
function PopupDruck2_Callback(hObject, eventdata, handles)
% hObject    handle to PopupDruck2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupDruck2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupDruck2
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
axes(handles.axes2);
if handles.pzwei == 0
    hold on
else
    cla(handles.axes1)
end

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(handles.axes2,time,A(2:end,Index))
legend(VAL);
xlabel('time');
ylabel('Temperatur in K');
grid on 
%% 0 heisst Druck, 1 heisst Level
handles.pzwei = 0;
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt




% --- Executes during object creation, after setting all properties.
function PopupDruck2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupDruck2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupFlow2.
function PopupFlow2_Callback(hObject, eventdata, handles)
% hObject    handle to PopupFlow2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupFlow2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupFlow2
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns PopupFlow1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupFlow1
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
axes(handles.axes1);
if handles.peins == 1
    hold on
else
    cla(handles.axes1)
end

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
plot(handles.axes1,time,A(2:end,Index))
legend(VAL);
xlabel('time');
ylabel('Durchfluss');
grid on 
handles.peins = 1;
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt



% --- Executes during object creation, after setting all properties.
function PopupFlow2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupFlow2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupLevel2.
function PopupLevel2_Callback(hObject, eventdata, handles)
% hObject    handle to PopupLevel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupLevel2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupLevel2
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

if handles.pzwei == 1
    hold on
else
    cla(handles.axes1)
end

%TR11_A_IN = A(2:end,Index); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
hold(handles.axes2) 
plot(handles.axes2,time,A(2:end,Index))
legend(VAL);
xlabel('time');
ylabel('Level in %');
grid on 
handles.pzwei = 1;
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt



% --- Executes during object creation, after setting all properties.
function PopupLevel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupLevel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clearaxes1.
function clearaxes1_Callback(hObject, eventdata, handles)
% hObject    handle to clearaxes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1)



% --- Executes on button press in clearaxes2.
function clearaxes2_Callback(hObject, eventdata, handles)
% hObject    handle to clearaxes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes2)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over PopupTemp1.
function PopupTemp1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to PopupTemp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
