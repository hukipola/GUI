%% -- Startsequenz --> automatisch erstellt --
%% Mit Matlab Lade Funktion!!!!

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

% Last Modified by GUIDE v2.5 14-Feb-2017 12:32:05

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



%% -- Ausführung vor Start der GUI --> Den Listen wird der Startwert übergeben --

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


%% -- Funktion zum Datenladen --

% --- Executes on button press in pushbutton_datenladen.
function pushbutton_datenladen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_datenladen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%----- Von hier an eigener Code -----

% Die handles werden aktualisiert
handles = guidata(hObject);
%% Laden aus einer Matlab file

% Fenster wird zum Laden geöffnet
[name,pfad] = uigetfile('*.mat','Lade');
% wenn nix ausgewählt wurde:
if name == 0
    set(handles.edit_bemerkung,'String',{'Fehler: Keine Daten geladen!'});      % Ausgabe Fehlermeldung
    set(handles.edit_bemerkung,'BackgroundColor','red');                        % Färben des Hintergrunds bei Fehlermeldung
    handles = guidata(hObject);
    return;
    % wenn was ausgewählt wurde:
else
    set(handles.edit_bemerkung,'String','Keine Bemerkungen');       % Zurücksetzen des Bemerkungsfeldes, falls vorher Fehlermeldung
    set(handles.edit_bemerkung,'BackgroundColor','white');          % Zurücksetzen auf weißen Hintergrund

    % Datei wird geladen, die beiden Strings stehen für die im Structure
    % enthaltenen Dateien. Diese müssen ebenso in der Datei, die eigelesen wird so benannt sein!
Laden_mat = load([pfad name],'logIDs','logVal');
Laden_mat.logIDs = Laden_mat.logIDs(1,:);
logIDs = Laden_mat.logIDs;
% Der String wird gesucht, der mit dem Namen Versuchszeit 8 character
% gemeinsam hat
zeitposition = find(strncmpi('Versuchszeit', logIDs,8));

% Die Werte aus dem eingelesenen Structure werden in die handles der GUI
% gespeichert
handles.logIDs = Laden_mat.logIDs;
handles.logVal = Laden_mat.logVal;
handles.time = handles.logVal(:,zeitposition);
% Der Zeitvektor wird umbenannt in einen String, den man verstehen kann
handles.time_string=datestr(handles.time,'dd:HH:MM:SS'); 

% Weitere Vektor mit Anzahl an Einträgen, über den die Zeitberechnung
% laufen kann. Dies entspricht einer Messwertaufzeichnung von einem Wert
% pro Sekunde ---> Wird benutzt beim Zuschneiden der Messwerte
handles.sekunden = 1:length(handles.time);
% handles.minuten = handles.sekunden/60; % Bei einer 1 sekündlichen Messwertaufzeichnung
% handles.stunden = handles.minuten/60;

%% Backup Daten werden in die handles geschrieben fuer das zuruecksetzen vom Beschneiden

handles.logIDs_tmp = Laden_mat.logIDs;
handles.logVal_tmp = Laden_mat.logVal;
handles.time_tmp = handles.logVal(:,zeitposition);
% Der Zeitvektor wird umbenannt in einen String, den man verstehen kann
handles.time_string_tmp=datestr(handles.time,'dd:HH:MM:SS'); 

% Weitere Vektor mit Anzahl an Einträgen, über den die Zeitberechnung
% laufen kann. Dies entspricht einer Messwertaufzeichnung von einem Wert
% pro Sekunde ---> Wird benutzt beim Zuschneiden der Messwerte
handles.sekunden_tmp = 1:length(handles.time); % hier wird der Vektor Sekunden in die einzelnen Einträge untertelt
% handles.minuten_tmp = handles.sekunden/60; % Bei einer 1 sekündlichen Messwertaufzeichnung
% handles.stunden_tmp = handles.minuten/60;


% Für zuschneiden nötig, in Funktion "crop". 0= es wurde noch nicht
% zugeschnitten
handles.croped = 0;

end
    % Einfügen einer Listenauswahl --> welcher Liste sollen die Vektoren aus dem Popup-Menü zugeordnet werden
        
    handles.listenzuordnung = 0;
   
   
    % Benennung des PopUpMenues:
    
    names = handles.logIDs(1:size(logIDs,2));  % Auslesen aller Einträge ab 6. Spalte (erster Vektor nach den Zeiten!!!)
    names{end+1} = '-Select-';  % als letzter Eintrag des Popups soll "select" stehen
    
    set(handles.popupmenu_vektorauswahl,'String',names);            % Einfügen der Vektornamen ins Popup
    set(handles.popupmenu_vektorauswahl,'Value',numel(names));      % Popup Menü wird auf letzten Eintrag "- Select -" gesetzt
    
    guidata(hObject, handles);                      % Übernahme der Änderungen

    
    handles = guidata(hObject);
    guidata(hObject, handles)


set(handles.edit_start_zeit,'String',handles.time_string(1,:))
set(handles.edit_end_zeit,'String',handles.time_string(end,:))
% Listen werden zurückgesetzt
set(handles.listbox_ausgewaehltevektoren1,'String',[]); 
set(handles.listbox_ausgewaehltevektoren2,'String',[]); 
set(handles.listbox_ausgewaehltevektoren3,'String',[]); 
set(handles.listbox_ausgewaehltevektoren4,'String',[]); 
set(handles.listbox_ausgewaehltevektoren5,'String',[]); 
set(handles.listbox_ausgewaehltevektoren6,'String',[]); 

% Abbildung wird gecleared
cla(gca)
reset(gca);
legend HIDE;

% Listenzuordnung wird auf 0 gesetzt

handles.listenzuordnung = 0;                        % Ändert die Variable "listenzuordnung" auf den Index der Liste 1

set(handles.edit1,'String','Nicht aktiviert');            % Ändert das Textfeld, wenn Liste 1 aktiviert wird
set(handles.edit2,'String','Nicht aktiviert');      % Ändert das Textfeld von Liste 2 auf "nicht aktiviert", wenn Liste 1 aktiviert wird
set(handles.edit3,'String','Nicht aktiviert');
set(handles.edit4,'String','Nicht aktiviert');
set(handles.edit5,'String','Nicht aktiviert');
set(handles.edit6,'String','Nicht aktiviert');


% Slider werden initialisiert
set(handles.slider_startzeit,'Min',handles.sekunden(1))
set(handles.slider_startzeit,'Max',handles.sekunden(end))
set(handles.slider_startzeit,'Value',handles.sekunden(1))
set(handles.slider_endzeit,'Min',handles.sekunden(1))
set(handles.slider_endzeit,'Max',handles.sekunden(end))
set(handles.slider_endzeit,'Value',handles.sekunden(end))

% ... und aktualisiert
guidata(hObject, handles)


%% Hier wird Drop-Down-Menü verwaltet --> Übernahme der Vektoren in die Listen + temporäres Plotten der Vektoren in Vorschau 

% --- Executes on selection change in popupmenu_vektorauswahl.
function popupmenu_vektorauswahl_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_vektorauswahl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_vektorauswahl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_vektorauswahl


%----- Von hier an eigener Code -----
% Damit die handles in dieser funktion ansprechbar sind müssen sie hiermit
% geladen werden
guidata(hObject, handles)

contents = cellstr(get(hObject,'String'));      % getroffene Auswahl wird als cell array ausgegeben
value = contents{get(hObject,'Value')};         % getroffene Auswahl wird von Cell-Array in char umgewandelt ??? --> über Variable "value" kann auf Auswahl als 'String' zugegriffen werden
VAL = cellstr(value);                           % wandelt die Auswahl wieder zurück in ein cell array --> siehe "help cellstr"

guidata(hObject, handles)
handles = guidata(hObject);
% mit diesem Befehl wird der Wert aus der Auswahl ausgelesen
contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
value = contents{get(hObject,'Value')};
VAL = cellstr(value);
logVal = handles.logVal;
logIDs = handles.logIDs;
Index = find(strcmp(VAL, logIDs));

% Aus den handles wird gelesen und in weitere Variablen gespeichert
time = handles.time;
time_string=datestr(handles.time,'dd:HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 

hold on; 
plot(handles.axes1,time,logVal(:,Index))
legend(VAL);
xlabel('time');
grid on 


guidata(hObject, handles)

% Die Ticks der x-achse werden anhand des Vektors, über den die Messwerte
% geplottet werden eingeteilt. In Viertel Schritte
set(gca, 'XTick', [time(1);time(round(length(time)/3));time(round(length(time)*2/3));time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
% Die Benennung der Ticks wird mit dem Vektor der lesbaren Zeiteinheiten
% beschriftet.
set(gca, 'XTickLabel',{time_string(1,:);time_string(round(length(time_string)/3),:);time_string(round(length(time_string)*2/3),:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

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


%% -- Aktivierung der Listen --

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

% Sobald eine andere Liste aktiviert wird, werden alte Einstellungen
% zurückgesetzt
cla(gca)
reset(gca);
legend HIDE;



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

cla(gca)
reset(gca);
legend HIDE;

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

cla(gca)
reset(gca);
legend HIDE;

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

cla(gca)
reset(gca);
legend HIDE;

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

cla(gca)
reset(gca);
legend HIDE;

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

cla(gca)
reset(gca);
legend HIDE;

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

%% -- Zum Löschen der getroffenen Auswahl einer Liste --

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

%% -- Funktion zum Plotten der gesamten Auswahl einer Liste in externe Figure --

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
logVal = handles.logVal;
logIDs = handles.logIDs;
time = handles.time;
time_string=datestr(time,'dd:HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 

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
            Index = find(strcmp(inhalt(z), logIDs));
        % Um zwei zur?cksetzen, um auf die Matrix A auszurichten
%            Index = Index - 2;
            plot(time,logVal(:,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
     set(gca, 'XTick', [time(1);time(round(length(time)/4));time(round(length(time)/2));time(round(length(time)*3/4));time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
        set(gca, 'XTickLabel',{time_string(1,:);time_string(round(length(time_string)/4),:);time_string(round(length(time_string)/2),:);time_string(round(length(time_string)*3/4),:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end

        
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
            Index = find(strcmp(inhalt(z), logIDs));
        % Um zwei zur?cksetzen, um auf die Matrix A auszurichten
            %Index = Index - 2;
            plot(time,logVal(:,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
%             set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
%             set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
     
        
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
            Index = find(strcmp(inhalt(z), logIDs));
        % Um zwei zur?cksetzen, um auf die Matrix A auszurichten
         
            plot(time,logVal(:,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
%             set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
%             set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
        
        
        
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
            Index = find(strcmp(inhalt(z), logIDs));
            plot(time,logVal(:,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
%             set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
%             set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
 
        
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
            Index = find(strcmp(inhalt(z), logIDs));
    
            plot(time,logVal(:,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
%             set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
%             set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
      
        
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
            Index = find(strcmp(inhalt(z), logIDs));

            plot(time,logVal(:,Index))
            xlabel('time');
            grid on 
            % die umgewandelte Zeit wird auf die x-Achse geschrieben
%             set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
%             set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

        end
        % die umgewandelte Zeit wird auf die x-Achse geschrieben
        set(gca, 'XTick', [time(1);time(round(length(time)/4));time(round(length(time)/2));time(round(length(time)*3/4));time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
        set(gca, 'XTickLabel',{time_string(1,:);time_string(round(length(time_string)/4),:);time_string(round(length(time_string)/2),:);time_string(round(length(time_string)*3/4),:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt


        % Die Legende wird mit den Werten vom String gefüllt.
    
        
        
end
%%   Die x-Achse wird mit dem Zeit vektor beschrieben und in viertel unterteilt
set(gca, 'XTick', [time(1);time(round(length(time)/4));time(round(length(time)/2));time(round(length(time)*3/4));time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
 set(gca, 'XTickLabel',{time_string(1,:);time_string(round(length(time_string)/4),:);time_string(round(length(time_string)/2),:);time_string(round(length(time_string)*3/4),:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegtguidata(hObject, handles)
  % Die Legende wird mit den Werten vom String gefüllt.
legend(inhalt)   
hold off

guidata(hObject, handles)                           % Übernahme der Änderungen


%% -- Löschen der Plots aus der vorläufigen Vorschau

% --- Executes on button press in pushbutton_temp_plot_loeschen.
function pushbutton_temp_plot_loeschen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_temp_plot_loeschen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Abbildung wird gecleared
cla(gca)
reset(gca);
legend HIDE;




function edit_start_zeit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_zeit as text
%        str2double(get(hObject,'String')) returns contents of edit_start_zeit as a double
inhalt = str2double(get(hObject,'String'));
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit_start_zeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_zeit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_zeit as text
%        str2double(get(hObject,'String')) returns contents of edit_end_zeit as a double
inhalt = str2double(get(hObject,'String'));
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit_end_zeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% -- Slider für Startzeitvorwahl --

% --- Executes on slider movement.
function slider_startzeit_Callback(hObject, eventdata, handles)
% hObject    handle to slider_startzeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% Der per Slider eingestellte Wert wird eingelesen
value = get(hObject,'Value');
% Das Textfeld wird mit diesem Wert beschrieben, wobei durch den Slider ein
% Index bekommen wurde, welcher mit dem time_string vektor auf eine Zeit
% verweist.
set(handles.edit_start_zeit,'String',handles.time_string(round(value),:))
guidata(hObject, handles)





% --- Executes during object creation, after setting all properties.
function slider_startzeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_startzeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% -- Slider zur Endzeitvorwahl

% --- Executes on slider movement.
function slider_endzeit_Callback(hObject, eventdata, handles)
% hObject    handle to slider_endzeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% Siehe Oben
value = get(hObject,'Value');
set(handles.edit_end_zeit,'String',handles.time_string(round(value),:))
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function slider_endzeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_endzeit (see GCBO)q
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_liste1_speichern.
function pushbutton_liste1_speichern_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_liste1_speichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Um für ein besseres handling zu sorgen werden die ausgewählten Dateien ausgelesen
logVal = handles.logVal;
logIDs = handles.logIDs;
time = handles.time;
time_string=datestr(time,'dd:HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
% Der Inhalt der ersten Listbox wird gelesen...
inhalt = get(handles.listbox_ausgewaehltevektoren1,'String');
% und zu einem String umgewandelt
inhalt = cellstr(inhalt);

% Für die Länge dieses Strings wird folgendes durchgeführt
for z=1:length(inhalt)
% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(inhalt(z), logIDs));
logVal(:,z) = logVal(:,Index);
end
% Beschreiben der zu speichernden Werte
logIDs = inhalt';
Zeit = time_string;
Versuchszeit = time;
% Abspeichern in der GUI
[save_name,save_pfad] = uiputfile('*.mat','Als Mat file speichern');
if save_name == 0 return, end
save(fullfile(save_pfad,save_name),'logVal','logIDs','Versuchszeit','Zeit')


% --- Executes on button press in pushbutton_liste2_speichern.
function pushbutton_liste2_speichern_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_liste2_speichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
logVal = handles.logVal;
logIDs = handles.logIDs;
time = handles.time;
time_string=datestr(time,'dd:HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
% Der Inhalt der ersten Listbox wird gelesen...
inhalt = get(handles.listbox_ausgewaehltevektoren2,'String');
% und zu einem String umgewandelt
inhalt = cellstr(inhalt);

for z=1:length(inhalt)
% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(inhalt(z), logIDs));
logVal(:,z) = logVal(:,Index);
end
logIDs = inhalt';
Zeit = time_string;
Versuchszeit = time;
[save_name,save_pfad] = uiputfile('*.mat','Als Mat file speichern');
if save_name == 0 return, end
save(fullfile(save_pfad,save_name),'logVal','logIDs','Versuchszeit','Zeit')


% --- Executes on button press in pushbutton_liste3_speichern.
function pushbutton_liste3_speichern_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_liste3_speichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
logVal = handles.logVal;
logIDs = handles.logIDs;
time = handles.time;
time_string=datestr(time,'dd:HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
% Der Inhalt der ersten Listbox wird gelesen...
inhalt = get(handles.listbox_ausgewaehltevektoren3,'String');
% und zu einem String umgewandelt
inhalt = cellstr(inhalt);

for z=1:length(inhalt)
% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(inhalt(z), logIDs));
logVal(:,z) = logVal(:,Index);
end
logIDs = inhalt';
Zeit = time_string;
Versuchszeit = time;
[save_name,save_pfad] = uiputfile('*.mat','Als Mat file speichern');
if save_name == 0 return, end
save(fullfile(save_pfad,save_name),'logVal','logIDs','Versuchszeit','Zeit')


% --- Executes on button press in pushbutton_liste4_speichern.
function pushbutton_liste4_speichern_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_liste4_speichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
logVal = handles.logVal;
logIDs = handles.logIDs;
time = handles.time;
time_string=datestr(time,'dd:HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
% Der Inhalt der ersten Listbox wird gelesen...
inhalt = get(handles.listbox_ausgewaehltevektoren4,'String');
% und zu einem String umgewandelt
inhalt = cellstr(inhalt);

for z=1:length(inhalt)
% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(inhalt(z), logIDs));
logVal(:,z) = logVal(:,Index);
end
logIDs = inhalt';
Zeit = time_string;
Versuchszeit = time;
[save_name,save_pfad] = uiputfile('*.mat','Als Mat file speichern');
if save_name == 0 return, end
save(fullfile(save_pfad,save_name),'logVal','logIDs','Versuchszeit','Zeit')


% --- Executes on button press in pushbutton_liste5_speichern.
function pushbutton_liste5_speichern_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_liste5_speichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
logVal = handles.logVal;
logIDs = handles.logIDs;
time = handles.time;
time_string=datestr(time,'dd:HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
% Der Inhalt der ersten Listbox wird gelesen...
inhalt = get(handles.listbox_ausgewaehltevektoren5,'String');
% und zu einem String umgewandelt
inhalt = cellstr(inhalt);

for z=1:length(inhalt)
% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(inhalt(z), logIDs));
logVal(:,z) = logVal(:,Index);
end
logIDs = inhalt';
Zeit = time_string;
Versuchszeit = time;
[save_name,save_pfad] = uiputfile('*.mat','Als Mat file speichern');
if save_name == 0 return, end
save(fullfile(save_pfad,save_name),'logVal','logIDs','Versuchszeit','Zeit')


% --- Executes on button press in pushbutton_liste6_speichern.
function pushbutton_liste6_speichern_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_liste6_speichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
logVal = handles.logVal;
logIDs = handles.logIDs;
time = handles.time;
time_string=datestr(time,'dd:HH:MM:SS'); % Zeitvektor ist immer der gleichegrid on 
% Der Inhalt der ersten Listbox wird gelesen...
inhalt = get(handles.listbox_ausgewaehltevektoren6,'String');
% und zu einem String umgewandelt
inhalt = cellstr(inhalt);

for z=1:length(inhalt)
% Auslesen, welcher Wert und damit welche Stelle ausgew?hlt wurde
Index = find(strcmp(inhalt(z), logIDs));
logVal(:,z) = logVal(:,Index);
end
logIDs = inhalt';
Zeit = time_string;
Versuchszeit = time;
[save_name,save_pfad] = uiputfile('*.mat','Als Mat file speichern');
if save_name == 0 return, end
save(fullfile(save_pfad,save_name),'logVal','logIDs','Versuchszeit','Zeit')


% --- Executes on button press in pushbutton_crop.
function pushbutton_crop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Abfrage, ob schonmal gecropped wurde. Mehrmaliges Zuschneiden
% funktioniert noch nicht fehlerfrei. Daher muss ein einmal zugeschnittener
% Vektor erneut eingelesen werden. Problem dabei ist die Numerierung der
% Zeiteinheiten. 
if handles.croped == 1
    set(handles.edit_bemerkung,'String','Fehler: bereits zugeschnitten')
    set(handles.edit_bemerkung,'BackgroundColor','red');
else
set(handles.edit_bemerkung,'BackgroundColor','white');
% Wert wird aus den Sliders ausgelesen und ...
startzeit = round(get(handles.slider_startzeit,'Value'));
endzeit = round(get(handles.slider_endzeit,'Value'));

% ... überprüft ob eine fehlerhafte Stellung vorherrscht...
if endzeit < startzeit
    set(handles.edit_bemerkung,'String','Fehler: Start>Ende')
    set(handles.edit_bemerkung,'BackgroundColor','red');
    return
else
    set(handles.edit_bemerkung,'BackgroundColor','white');
end
    
    % Der Zeitvektor in den handles wird zugeschnitten, damit ist der
    % Speicher schon zugeschnitten

    handles.time = handles.time(startzeit:endzeit);

    handles.logVal = handles.logVal(startzeit:endzeit,:);
    handles.sekunden = handles.sekunden(startzeit:endzeit);
    handles.minuten = handles.sekunden/60; % Bei einer 1 sekündlichen Messwertaufzeichnung
    handles.stunden = handles.minuten/60;
    % Slider werden neu initialisiert
set(handles.slider_startzeit,'Min',handles.sekunden(1))
set(handles.slider_startzeit,'Max',handles.sekunden(end))
set(handles.slider_startzeit,'Value',handles.sekunden(1))

set(handles.slider_endzeit,'Min',handles.sekunden(1))
set(handles.slider_endzeit,'Max',handles.sekunden(end))
set(handles.slider_endzeit,'Value',handles.sekunden(end))

% Variable wird auf 1 gesetzt, da einmal zugeschnitten wurde.
% Fehlermeldung weist den Benutzer auf diesen zustand hin
handles.croped = 1;
end

guidata(hObject, handles)




% --- Executes on button press in pushbutton_zuschnittspeichern.
function pushbutton_zuschnittspeichern_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_zuschnittspeichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Ab hier automatischen Speichern der zugeschnittenen Daten. Es wird hier
% der gesamte Datensatz für den zugeschnittenen Bereich gespeichert. Alle
% Variablen. Um eine zweite Zuschneidung durchzuführen, müssen die hier
% abgespeicherten Dateien erneut eingelesen werden. Dies ist ohne Fehler
% möglich.
logVal = handles.logVal;
logIDs = handles.logIDs;
Versuchszeit = handles.time;
Zeit = datestr(handles.time,'dd:HH:MM:SS');
[save_name,save_pfad] = uiputfile('*.mat','Als Mat file speichern');
if save_name == 0 return, end
save(fullfile(save_pfad,save_name),'logVal','logIDs','Versuchszeit','Zeit')








% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd ..


% --- Executes on button press in pushbutton_zurueck.
function pushbutton_zurueck_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_zurueck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.logIDs = handles.logIDs_tmp;
handles.logVal = handles.logVal_tmp;
handles.time = handles.time_tmp;
% Der Zeitvektor wird umbenannt in einen String, den man verstehen kann
handles.time_string=handles.time_string_tmp; 
guidata(hObject, handles)
% Weitere Vektor mit Anzahl an Einträgen, über den die Zeitberechnung
% laufen kann. Dies entspricht einer Messwertaufzeichnung von einem Wert
% pro Sekunde ---> Wird benutzt beim Zuschneiden der Messwerte
handles.sekunden = handles.sekunden_tmp; % hier wird der Vektor Sekunden in die einzelnen Einträge untertelt
% handles.minuten = handles.minuten_tmp; % Bei einer 1 sekündlichen Messwertaufzeichnung
% handles.stunden = handles.stunden_tmp;
guidata(hObject, handles)

set(handles.edit_bemerkung,'String','Keine Bemerkung');
set(handles.edit_bemerkung,'BackgroundColor','white');

% Slider werden erneut initialisiert
set(handles.slider_startzeit,'Min',handles.sekunden(1))
set(handles.slider_startzeit,'Max',handles.sekunden(end))
set(handles.slider_startzeit,'Value',handles.sekunden(1))
set(handles.slider_endzeit,'Min',handles.sekunden(1))
set(handles.slider_endzeit,'Max',handles.sekunden(end))
set(handles.slider_endzeit,'Value',handles.sekunden(end))

% Edit boxen werden zurückgesetzt
set(handles.edit_start_zeit,'String',handles.time_string(1,:))
set(handles.edit_end_zeit,'String',handles.time_string(end,:))
handles.croped = 0;
guidata(hObject, handles)



