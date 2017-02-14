function [] = funk_excel2mat_alle()
%% Konvertieren aller Excel-Files eines Ordners in Mat-Files

%% Auswahl des Verzeichnisses mit den zu konvertierenden Excel-Files
load_pfad = uigetdir('', 'W�hlen Sie den ORDNER mit den zu konvertierenden EXCEL-FILES aus:');
if load_pfad==0 return, end %f�r Abbrechen-Button
Files = dir(load_pfad);

%% Auswahl des Zielverzeichnisses f�r die erzeugten Mat-Files
save_pfad = uigetdir('', 'W�hlen Sie den ZIELORDNER f�r die MAT-FILES aus:');
if save_pfad==0 return, end %f�r Abbrechen-Button

%% Auslesen der Excel-Files und Abspeichern als Mat-Files mit gleichem Namen
for i = 1:length(Files)
    
    %if-Abfrage, um nur Excel-Files zu �ffnen, Unterordner und andere
    %Dateitypen werden ignoriert

    %ERKL�RUNG: strfind gibt, wenn das entsprechende 'String' gefunden
    %wird, dessen Position zur�ck, wenn es nicht gefunden wird, nichts
    %([]). Entspricht die Datei Files(i).name nicht einer der gew�nschten
    %Dateitypen ('.xls', '.csv'), folgt somit auf die Abfrage isempty eine
    %logische 1 und nichts passiert (else), sonst l�uft die if-routine ab.
    if isempty(strfind(Files(i).name, '.xls')) == 0 || isempty(strfind(Files(i).name, '.csv')) == 0

        %% Auslesen des Files
        %Hier ist eine Unterscheidung zwischen '.xls*' und '.csv' n�tig, da
        %.csv-Files nur ein Sheet enthalten k�nnen. Bei dem Messdaten-Recorder von
        %Stephan Holz sind die Messwerte bei den '.xls*'-Typen allerdings auf Sheet 2!

        %ERKL�RUNG: strfind gibt, wenn das entsprechende 'String' gefunden
        %wird, dessen Position zur�ck, wenn es nicht gefunden wird, nichts
        %([]). Entspricht die Datei Files(i).name nicht einer der gew�nschten
        %Dateitypen ('.xls', '.csv'), folgt somit auf die Abfrage isempty eine
        %logische 1 und nichts passiert (else), sonst l�uft die if-routine ab.
        if isempty(strfind(Files(i).name, '.xls')) == 0 
            %Excel-File (kann mehrere Sheets enthalten, auch auf versteckte Sheets achten!)
            [logVal,logIDs] = xlsread([load_pfad '\' Files(i).name],2); %2 steht f�r Sheet 2!!!
        else
            %CSV-File (kann nur ein Sheet enthalten!)
            [logVal,logIDs] = xlsread([load_pfad '\' Files(i).name]); 

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

        %% Abspeichern als Mat-File (Mat-Data)
        %Generieren eines Dateinamens, der den urspr�nglichen Dateityp
        %('.xls', '.csv') nicht mehr enth�lt, da sonst nicht als Mat-File
        %abgespeichert wird, sondern als urspr�nglicher Dateityp!
        
        %ANMERKUNG: enthalten die Dateinamen durch Zufall die zu l�schenden
        %Endungen, kann das hier zu Fehlern f�hren!!! -> andere L�sung
        %suchen!
        
        %ERKL�RUNG: strfind findet die Position der Endung im Dateinamen,
        %danach wird alles gel�scht (hier k�nnte der eben genannte Fehler
        %auftreten!). '.xls' erschl�gt somit auch Excelformate wie '.xlsm'
        %oder '.xlsx' usw.
        
        Files(i).name(strfind(Files(i).name, '.xls'):length(Files(i).name)) = [];
        Files(i).name(strfind(Files(i).name, '.csv'):length(Files(i).name)) = [];
        
        save(fullfile(save_pfad, [Files(i).name '.mat']), 'logIDs', 'logVal')

    else %hier passiert nichts
    end %End if-Bedingungen
end  %End for-Schleife

end %Funktionsende

