function [] = funk_excel2mat_einzel()
%% Konvertieren eines einzelnen Excel-Files in Mat-Files

%% Auswahl des entsprechenden Files
%Diese File-Typen werden im Dropdown-Men� des Popup-Fensters angezeigt.
%Alternativ kann bei uigetfile anstatt Auswahl auch '*' eingetragen werden,
%dann werden automatisch immer alle Dateien angezeigt (un�bersichtlich)
Auswahloption{1,1} = '*.csv'; 
Auswahloption{2,1} = '*.xls*'; %.xls, .xlsx, .xlsm...
%F�r weitere File-Typen erweitern!

[load_name, load_pfad] = uigetfile(Auswahloption, 'Bitte gew�nschte Excel-Datei ausw�hlen');
if load_name==0 return, end %f�r Abbrechen-Button

%% Auslesen des Files
%Hier ist eine Unterscheidung zwischen '.xls*' und '.csv' n�tig, da
%.csv-Files nur ein Sheet enthalten k�nnen. Bei dem Messdaten-Recorder von
%Stephan Holz sind die Messwerte bei den '.xls*'-Typen allerdings auf Sheet 2!

%ERKL�RUNG: strfind gibt, wenn das entsprechende 'String' gefunden
%wird, dessen Position zur�ck, wenn es nicht gefunden wird, nichts
%([]). Entspricht die Datei load_name nicht einer der gew�nschten
%Dateitypen ('.xls', '.csv'), folgt somit auf die Abfrage isempty eine
%logische 1 und nichts passiert (else), sonst l�uft die if-routine ab.
if isempty(strfind(load_name, '.xls')) == 0 
    %Excel-File (kann mehrere Sheets enthalten, auch auf versteckte Sheets achten!)
    [logVal,logIDs] = xlsread([load_pfad load_name],2); %2 steht f�r Sheet 2!!!
else
    %CSV-File (kann nur ein Sheet enthalten!)
    [logVal,logIDs] = xlsread([load_pfad load_name]); 
    
    %F�r weitere File-Typen weitere elseif-Abfragen einbauen!
end

%% Entfernen unben�tigter Spalten (z.B. Datum) und Zeilen (z.B. Momentanwert)
%-> Wichtig: Spalten der Variablennamen und der dazugeh�rigen Messwerte 
%m�ssen dann �bereinstimmen (z.B. Messtelle in 'logIDs' in Spalte 1 
%sowie die dazugeh�rigen Messwerte in 'logVal' in Spalte 1!!!)

logVal(:,1:3) = []; %ersten 4 Spalten verwerfen (da unn�tz)
logIDs(:,1:4) = []; %ersten 5 Spalten verwerfen

logVal(1,:) = []; %erste Zeile der Daten l�schen
logIDs(3:size(logIDs, 1),:) = []; %nur die ersten Zeilen sind wichtig

%% Auswahl des Speicherpfads
[save_name, save_pfad] = uiputfile('*.mat', 'Als Mat-File abspeichern:'); 
if save_name==0 return, end %f�r Abbrechen-Button

%% Abspeichern als Mat-File (Mat-Data)
save(fullfile(save_pfad, save_name), 'logIDs', 'logVal')

end %Funktionsende