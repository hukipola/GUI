function varargout = GUI_DBTA_2(varargin)
% GUI_DBTA_2 MATLAB code for GUI_DBTA_2.fig
%      GUI_DBTA_2, by itself, creates a new GUI_DBTA_2 or raises the existing
%      singleton*.
%
%      H = GUI_DBTA_2 returns the handle to a new GUI_DBTA_2 or the handle to
%      the existing singleton*.
%
%      GUI_DBTA_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DBTA_2.M with the given input arguments.
%
%      GUI_DBTA_2('Property','Value',...) creates a new GUI_DBTA_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_DBTA_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_DBTA_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_DBTA_2

% Last Modified by GUIDE v2.5 07-Feb-2017 14:51:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_DBTA_2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_DBTA_2_OutputFcn, ...
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


% --- Executes just before GUI_DBTA_2 is made visible.
function GUI_DBTA_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_DBTA_2 (see VARARGIN)

% Choose default command line output for GUI_DBTA_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


%----- Von hier an eigener Code -----

set(handles.listbox_ausgewaehltevektoren1,'String',[]);     % setzt leeren Start-"String" in die Listbox --> Startwert wichtig für Überschreiben in Funktion des Popupmenu
set(handles.listbox_ausgewaehltevektoren2,'String',[]);     % setzt leeren Start-"String" in die Listbox --> Startwert wichtig für Überschreiben in Funktion des Popupmenu
set(handles.listbox_ausgewaehltevektoren3,'String',[]);     % setzt leeren Start-"String" in die Listbox --> Startwert wichtig für Überschreiben in Funktion des Popupmenu
set(handles.listbox_ausgewaehltevektoren4,'String',[]);     % setzt leeren Start-"String" in die Listbox --> Startwert wichtig für Überschreiben in Funktion des Popupmenu
set(handles.listbox_ausgewaehltevektoren5,'String',[]);     % setzt leeren Start-"String" in die Listbox --> Startwert wichtig für Überschreiben in Funktion des Popupmenu
set(handles.listbox_ausgewaehltevektoren6,'String',[]);     % setzt leeren Start-"String" in die Listbox --> Startwert wichtig für Überschreiben in Funktion des Popupmenu


% UIWAIT makes GUI_DBTA_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_DBTA_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_datenladen.
function pushbutton_datenladen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_datenladen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%----- Von hier an eigener Code -----

% Die handles werden aktualisiert
handles = guidata(hObject);
filename = uigetfile({'*.xls'},'Open Excel Sheet'); % Festlegen des Namens
if filename == 0
    set(handles.edit_bemerkung,'String',{'Fehler: Keine Daten geladen!'});      % Ausgabe Fehlermeldung
    set(handles.edit_bemerkung,'BackgroundColor','red');                        % Färben des Hintergrunds bei Fehlermeldung
    handles = guidata(hObject);
    return
else
    set(handles.edit_bemerkung,'String','Keine Bemerkungen');       % Zurücksetzen des Bemerkungsfeldes, falls vorher Fehlermeldung
    set(handles.edit_bemerkung,'BackgroundColor','white');          % Zurücksetzen auf weißen Hintergrund
    
    [type,sheetname] = xlsfinfo(filename);      %Abfragen der Informationen ueber das Excel File
    sheet = sheetname{2};                       % Welche Blätter sollen eingelesen werden? Hier muss der Name des Blattes stehen und nicht die Nummer oder so.
    guidata(hObject, handles);              % Übernahme der Änderungen
    [A,TXT,RAW]=xlsread(filename,sheet);        % Einlesen der Daten. A ist die Matrix mit den Werten, TXT ist die Matrix mit dem Header und Raw der ganze rest nochmal zusammen
    A = snip(A,nan);                            % Herausschneiden der nicht geschriebenen Werte
    TXT = TXT (1,:);                            % Es wird nur die erste Zeile benutzt
    
    % Die gelesenen Matrizen werden in die function handles geschrieben
    handles.A = A;
    handles.TXT = TXT;
    handles.RAW = RAW;
    
    % Einfügen einer Listenauswahl --> welcher Liste sollen die Vektoren aus dem Popup-Menü zugeordnet werden
        
    handles.listenzuordnung = 0;
   
   
    % Benennung des PopUpMenues:
    
    names = handles.TXT(6:size(TXT,2));  % Auslesen aller Einträge ab 6. Spalte (erster Vektor nach den Zeiten!!!)
    names{end+1} = '-Select-';  % als letzter Eintrag des Popups soll "select" stehen
    
    set(handles.popupmenu_vektorauswahl,'String',names);            % Einfügen der Vektornamen ins Popup
    set(handles.popupmenu_vektorauswahl,'Value',numel(names));      % Popup Menü wird auf letzten Eintrag "- Select -" gesetzt
    
    guidata(hObject, handles);                      % Übernahme der Änderungen

    
    handles = guidata(hObject);
    guidata(hObject, handles)
end
time = A(2:end,3);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 

% ... und aktualisiert
set(handles.edit_startzeit,'String',time_string(1,:));
set(handles.edit_endzeit,'String',time_string(end,:));
guidata(hObject, handles)


% --- Executes on selection change in popupmenu_vektorauswahl.
function popupmenu_vektorauswahl_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_vektorauswahl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_vektorauswahl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_vektorauswahl


%----- Von hier an eigener Code -----
guidata(hObject, handles)


contents = cellstr(get(hObject,'String'));      % getroffene Auswahl wird als cell array ausgegeben
value = contents{get(hObject,'Value')};         % getroffene Auswahl wird von Cell-Array in char umgewandelt ??? --> über Variable "value" kann auf Auswahl als 'String' zugegriffen werden
VAL = cellstr(value);                           % wandelt die Auswahl wieder zurück in ein cell array --> siehe "help cellstr"
% 
% % Übernehmen der Daten vom Auslesen der Daten
% A = handles.A;
% TXT = handles.TXT;
% RAW = handles.RAW;

% % Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
% Index = find(strcmp(VAL, TXT));
% % Um einen zur?cksetzen, um auf die Matrix A auszurichten
% Index = Index - 1;
guidata(hObject, handles)
handles = guidata(hObject);
% mit diesem Befehl wird der Wert aus der Auswahl ausgelesen
contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
value = contents{get(hObject,'Value')};
VAL = cellstr(value);
A = handles.A;
TXT = handles.TXT;
RAW = handles.RAW;
Index = find(strcmp(VAL, TXT));
% Um einen zur?cksetzen, um auf die Matrix A auszurichten
Index = Index - 2;

time = A(2:end,3);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 

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

switch handles.listenzuordnung                   % Case-Unterscheidung je nachdem welche Liste aktiviert ist!!!
    case 0
        set(handles.edit_bemerkung,'String','Fehler: Aktiviere eine Liste');        % Fehlermeldung, wenn keine Liste aktiviert ist
        set(handles.edit_bemerkung,'BackgroundColor','red');                        % roter Hintergrund in Fehlermeldung
        
    case 1

        set(handles.edit_bemerkung,'String','Keine Bemerkungen');                   % Setzt Fehlermeldung zurück, falls aktiv
        set(handles.edit_bemerkung,'BackgroundColor','white');                      % Setzt Hintergrund zurück auf weiß
        old_str = get(handles.listbox_ausgewaehltevektoren1,'String');              % Ließt bisherigen String (Vektor!) aus, falls vorhanden (Startwert wird zu Beginn des Programms auf leeren Vektor [] gesetzt)
        new_str = strvcat(old_str,value);                                           % erweitert bisherigen String (Vektor!) um einen Eintrag --> die getroffene Auswahl aus Popup Menü (--> als char gespeichert auf Variable "value")
        set(handles.listbox_ausgewaehltevektoren1,'String',new_str);                % Übergibt der ausgewählten Liste den neuen String 
        
    case 2
        
        set(handles.edit_bemerkung,'String','Keine Bemerkungen');
        set(handles.edit_bemerkung,'BackgroundColor','white');
        old_str = get(handles.listbox_ausgewaehltevektoren2,'String');
        new_str = strvcat(old_str,value);
        set(handles.listbox_ausgewaehltevektoren2,'String',new_str);
        
    case 3
       
        set(handles.edit_bemerkung,'String','Keine Bemerkungen');
        set(handles.edit_bemerkung,'BackgroundColor','white');
        old_str = get(handles.listbox_ausgewaehltevektoren3,'String');
        new_str = strvcat(old_str,value);
        set(handles.listbox_ausgewaehltevektoren3,'String',new_str);
        
    case 4
       
        set(handles.edit_bemerkung,'String','Keine Bemerkungen');
        set(handles.edit_bemerkung,'BackgroundColor','white');
        old_str = get(handles.listbox_ausgewaehltevektoren4,'String');
        new_str = strvcat(old_str,value);
        set(handles.listbox_ausgewaehltevektoren4,'String',new_str);
        
    case 5
        
        set(handles.edit_bemerkung,'String','Keine Bemerkungen');
        set(handles.edit_bemerkung,'BackgroundColor','white');
        old_str = get(handles.listbox_ausgewaehltevektoren5,'String');
        new_str = strvcat(old_str,value);
        set(handles.listbox_ausgewaehltevektoren5,'String',new_str);
        
    case 6
        
        set(handles.edit_bemerkung,'String','Keine Bemerkungen');
        set(handles.edit_bemerkung,'BackgroundColor','white');
        old_str = get(handles.listbox_ausgewaehltevektoren6,'String');
        new_str = strvcat(old_str,value);
        set(handles.listbox_ausgewaehltevektoren6,'String',new_str);
        
end


guidata(hObject, handles)                           % Übernahme der Änderungen


% --- Executes during object creation, after setting all properties.
function popupmenu_vektorauswahl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_vektorauswahl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ausgewaehltevektoren1.
function listbox_ausgewaehltevektoren1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ausgewaehltevektoren1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ausgewaehltevektoren1


% --- Executes during object creation, after setting all properties.
function listbox_ausgewaehltevektoren1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ausgewaehltevektoren3.
function listbox_ausgewaehltevektoren3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ausgewaehltevektoren3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ausgewaehltevektoren3


% --- Executes during object creation, after setting all properties.
function listbox_ausgewaehltevektoren3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ausgewaehltevektoren4.
function listbox_ausgewaehltevektoren4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ausgewaehltevektoren4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ausgewaehltevektoren4


% --- Executes during object creation, after setting all properties.
function listbox_ausgewaehltevektoren4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ausgewaehltevektoren2.
function listbox_ausgewaehltevektoren2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ausgewaehltevektoren2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ausgewaehltevektoren2


% --- Executes during object creation, after setting all properties.
function listbox_ausgewaehltevektoren2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ausgewaehltevektoren5.
function listbox_ausgewaehltevektoren5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ausgewaehltevektoren5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ausgewaehltevektoren5


% --- Executes during object creation, after setting all properties.
function listbox_ausgewaehltevektoren5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ausgewaehltevektoren6.
function listbox_ausgewaehltevektoren6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ausgewaehltevektoren6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ausgewaehltevektoren6


% --- Executes during object creation, after setting all properties.
function listbox_ausgewaehltevektoren6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_aktivieren1.
function pushbutton_aktivieren1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aktivieren1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%----- von hier an eigener Code -----
handles.listenzuordnung = 1;                        % Ändert die Variable "listenzuordnung" auf den Index der Liste 1

set(handles.edit1,'String','Aktiviert');            % Ändert das Textfeld, wenn Liste 1 aktiviert wird
set(handles.edit2,'String','Nicht aktiviert');      % Ändert das Textfeld von Liste 2 auf "nicht aktiviert", wenn Liste 1 aktiviert wird
set(handles.edit3,'String','Nicht aktiviert');
set(handles.edit4,'String','Nicht aktiviert');
set(handles.edit5,'String','Nicht aktiviert');
set(handles.edit6,'String','Nicht aktiviert');


guidata(hObject, handles)


% --- Executes on button press in pushbutton_aktivieren2.
function pushbutton_aktivieren2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aktivieren2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%----- von hier an eigener Code -----
handles.listenzuordnung = 2;

set(handles.edit1,'String','Nicht aktiviert');
set(handles.edit2,'String','Aktiviert');
set(handles.edit3,'String','Nicht aktiviert');
set(handles.edit4,'String','Nicht aktiviert');
set(handles.edit5,'String','Nicht aktiviert');
set(handles.edit6,'String','Nicht aktiviert');

guidata(hObject, handles)


% --- Executes on button press in pushbutton_aktivieren3.
function pushbutton_aktivieren3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aktivieren3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.listenzuordnung = 3;

set(handles.edit1,'String','Nicht aktiviert');
set(handles.edit2,'String','Nicht aktiviert');
set(handles.edit3,'String','Aktiviert');
set(handles.edit4,'String','Nicht aktiviert');
set(handles.edit5,'String','Nicht aktiviert');
set(handles.edit6,'String','Nicht aktiviert');

guidata(hObject, handles)


% --- Executes on button press in pushbutton_aktivieren4.
function pushbutton_aktivieren4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aktivieren4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.listenzuordnung = 4;

set(handles.edit1,'String','Nicht aktiviert');
set(handles.edit2,'String','Nicht aktiviert');
set(handles.edit3,'String','Nicht aktiviert');
set(handles.edit4,'String','Aktiviert');
set(handles.edit5,'String','Nicht aktiviert');
set(handles.edit6,'String','Nicht aktiviert');

guidata(hObject, handles)


% --- Executes on button press in pushbutton_aktivieren5.
function pushbutton_aktivieren5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aktivieren5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.listenzuordnung = 5;

set(handles.edit1,'String','Nicht aktiviert');
set(handles.edit2,'String','Nicht aktiviert');
set(handles.edit3,'String','Nicht aktiviert');
set(handles.edit4,'String','Nicht aktiviert');
set(handles.edit5,'String','Aktiviert');
set(handles.edit6,'String','Nicht aktiviert');

guidata(hObject, handles)


% --- Executes on button press in pushbutton_aktivieren6.
function pushbutton_aktivieren6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aktivieren6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.listenzuordnung = 6;

set(handles.edit1,'String','Nicht aktiviert');
set(handles.edit2,'String','Nicht aktiviert');
set(handles.edit3,'String','Nicht aktiviert');
set(handles.edit4,'String','Nicht aktiviert');
set(handles.edit5,'String','Nicht aktiviert');
set(handles.edit6,'String','Aktiviert');

guidata(hObject, handles)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_bemerkung_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bemerkung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bemerkung as text
%        str2double(get(hObject,'String')) returns contents of edit_bemerkung as a double


% --- Executes during object creation, after setting all properties.
function edit_bemerkung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bemerkung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_loeschen1.
function pushbutton_loeschen1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loeschen1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%----- Von hier an eigener Code -----

set(handles.listbox_ausgewaehltevektoren1,'String',[]);         % Übergibt der ausgewählten Liste den neuen leeren String [] --> bestehende Auswahl wird gelöscht


% --- Executes on button press in pushbutton_loeschen2.
function pushbutton_loeschen2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loeschen2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%----- Von hier an eigener Code -----

set(handles.listbox_ausgewaehltevektoren2,'String',[]);



% --- Executes on button press in pushbutton_loeschen3.
function pushbutton_loeschen3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loeschen3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





%----- Von hier an eigener Code -----

set(handles.listbox_ausgewaehltevektoren3,'String',[]);


% --- Executes on button press in pushbutton_loeschen4.
function pushbutton_loeschen4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loeschen4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%----- Von hier an eigener Code -----

set(handles.listbox_ausgewaehltevektoren4,'String',[]);


% --- Executes on button press in pushbutton_loeschen5.
function pushbutton_loeschen5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loeschen5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%----- Von hier an eigener Code -----

set(handles.listbox_ausgewaehltevektoren5,'String',[]);


% --- Executes on button press in pushbutton_loeschen6.
function pushbutton_loeschen6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loeschen6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%----- Von hier an eigener Code -----

set(handles.listbox_ausgewaehltevektoren6,'String',[]);


% --- Executes on button press in pushbutton_plotten.
function pushbutton_plotten_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plotten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ----- Von hier an eigener Code -----
% In dieser Funktion wird wieder der Wert der listenzuordnung ausgelesen,
% um die Werte in der aktivierten Liste plotten zu können. 
% Wird eine andere Liste aktiviert können damit in einer neuen figure die
% Werte dort geplottet werden.

% Übernehmen der Daten vom Auslesen der Daten
A = handles.A;
TXT = handles.TXT;
RAW = handles.RAW;
  time = A(2:end,3);
  time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 

switch handles.listenzuordnung                   % Case-Unterscheidung je nachdem welche Liste aktiviert ist!!!
    case 0
        set(handles.edit_bemerkung,'String','Fehler: Aktiviere eine Liste');        % Fehlermeldung, wenn keine Liste aktiviert ist
        set(handles.edit_bemerkung,'BackgroundColor','red');                        % roter Hintergrund in Fehlermeldung
    case 1
        % Der Inhalt der ersten Listbox wird gelesen...
        inhalt = get(handles.listbox_ausgewaehltevektoren1,'String');
        % und zu einem String umgewandelt
        inhalt = cellstr(inhalt);
        
        %% Neue Figure wird aufgebaut. Ab hier wird geplottet
        figure
        % für die gesamte Länge vom Vektor der Strings des Inhaltes
        for z=1:length(inhalt)
            hold on
          % Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
            Index = find(strcmp(inhalt(z), TXT));
        % Um einen zur?cksetzen, um auf die Matrix A auszurichten
            Index = Index - 2;
            plot(time,A(2:end,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
            set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
            set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
        % Die Legende wird mit den Werten vom String gefüllt.
        legend(inhalt)       
    case 2
         % Der Inhalt der Listbox wird gelesen...
        inhalt = get(handles.listbox_ausgewaehltevektoren2,'String');
        % und zu einem String umgewandelt
        inhalt = cellstr(inhalt);
        
        %% Neue Figure wird aufgebaut. Ab hier wird geplottet
        figure
        % für die gesamte Länge vom Vektor der Strings des Inhaltes
        for z=1:length(inhalt)
            hold on
          % Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
            Index = find(strcmp(inhalt(z), TXT));
        % Um einen zur?cksetzen, um auf die Matrix A auszurichten
            Index = Index - 2;
            plot(time,A(2:end,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
            set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
            set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
        % Die Legende wird mit den Werten vom String gefüllt.
        legend(inhalt)       
        
    case 3
         % Der Inhalt der Listbox wird gelesen...
        inhalt = get(handles.listbox_ausgewaehltevektoren3,'String');
        % und zu einem String umgewandelt
        inhalt = cellstr(inhalt);
        
        %% Neue Figure wird aufgebaut. Ab hier wird geplottet
        figure
        % für die gesamte Länge vom Vektor der Strings des Inhaltes
        for z=1:length(inhalt)
            hold on
          % Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
            Index = find(strcmp(inhalt(z), TXT));
        % Um einen zur?cksetzen, um auf die Matrix A auszurichten
            Index = Index - 2;
            plot(time,A(2:end,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
            set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
            set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
        % Die Legende wird mit den Werten vom String gefüllt.
        legend(inhalt)       
        
        
    case 4
      % Der Inhalt der Listbox wird gelesen...
        inhalt = get(handles.listbox_ausgewaehltevektoren4,'String');
        % und zu einem String umgewandelt
        inhalt = cellstr(inhalt);
        
        %% Neue Figure wird aufgebaut. Ab hier wird geplottet
        figure
        % für die gesamte Länge vom Vektor der Strings des Inhaltes
        for z=1:length(inhalt)
            hold on
          % Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
            Index = find(strcmp(inhalt(z), TXT));
        % Um einen zur?cksetzen, um auf die Matrix A auszurichten
            Index = Index - 2;
            plot(time,A(2:end,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
            set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
            set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
        % Die Legende wird mit den Werten vom String gefüllt.
        legend(inhalt)       
        
    case 5
           % Der Inhalt der Listbox wird gelesen...
        inhalt = get(handles.listbox_ausgewaehltevektoren5,'String');
        % und zu einem String umgewandelt
        inhalt = cellstr(inhalt);
        
        %% Neue Figure wird aufgebaut. Ab hier wird geplottet
        figure
        % für die gesamte Länge vom Vektor der Strings des Inhaltes
        for z=1:length(inhalt)
            hold on
          % Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
            Index = find(strcmp(inhalt(z), TXT));
        % Um einen zur?cksetzen, um auf die Matrix A auszurichten
            Index = Index - 2;
            plot(time,A(2:end,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
            set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
            set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
        % Die Legende wird mit den Werten vom String gefüllt.
        legend(inhalt)       
        
    case 6
          % Der Inhalt der Listbox wird gelesen...
        inhalt = get(handles.listbox_ausgewaehltevektoren6,'String');
        % und zu einem String umgewandelt
        inhalt = cellstr(inhalt);
        
        %% Neue Figure wird aufgebaut. Ab hier wird geplottet
        figure
        % für die gesamte Länge vom Vektor der Strings des Inhaltes
        for z=1:length(inhalt)
            hold on
          % Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
            Index = find(strcmp(inhalt(z), TXT));
        % Um einen zur?cksetzen, um auf die Matrix A auszurichten
            Index = Index - 2;
            plot(time,A(2:end,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
            set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
            set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
        % Die Legende wird mit den Werten vom String gefüllt.
        legend(inhalt)       
        
        
end
hold off

guidata(hObject, handles)                           % Übernahme der Änderungen


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over listbox_ausgewaehltevektoren1.
function listbox_ausgewaehltevektoren1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ausgewaehltevektoren1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles)
handles = guidata(hObject);
% mit diesem Befehl wird der Wert aus der Auswahl ausgelesen
contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
value = contents{get(hObject,'Value')};
VAL = cellstr(value);
A = handles.A;
TXT = handles.TXT;
RAW = handles.RAW;
Index = find(strcmp(VAL, TXT));
% Um einen zur?cksetzen, um auf die Matrix A auszurichten
Index = Index - 2;

time = A(2:end,3);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 

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

%


% --- Executes on button press in pushbutton_temp_plot_loeschen.
function pushbutton_temp_plot_loeschen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_temp_plot_loeschen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1)



function edit_startzeit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_startzeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_startzeit as text
%        str2double(get(hObject,'String')) returns contents of edit_startzeit as a double


% --- Executes during object creation, after setting all properties.
function edit_startzeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_startzeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_endzeit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_endzeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_endzeit as text
%        str2double(get(hObject,'String')) returns contents of edit_endzeit as a double


% --- Executes during object creation, after setting all properties.
function edit_endzeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_endzeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
