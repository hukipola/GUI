clear all
clc

%% Read von Messwerten
% 1) Excel Datei abspeichern
% 2) Dateinamen eintragen
% 3) Sheet Namen eintragen
% 4) Ausw?hlen welche Variablen geplottet werden sollen
filename = uigetfile({'*.xls'},'Open Excel Sheet'); % Festlegen des Namens
[type,sheetname] = xlsfinfo(filename);
sheet = sheetname{2}; % Welche Bl?tter sollen eingelesen werden? Hier muss der Name des Blattes stehen und nicht die Nummer oder so.

[A,TXT,RAW]=xlsread(filename,sheet); % Einlesen der Daten. Numeric ist die Matrix mit den Werten, TXT ist die Matrix mit dem Header und Raw der ganze rest nochmal zusammen
A = snip(A,nan); % Herausschneiden der nicht geschriebenen Werte



% choice_temp = menuN('Welche Temperatur?',{'TR11','TR12','TR13','TR14','TR15','TR16'});

TR11_A_IN = A(2:end,5); % Ausw?hlen der gew?nschten Variablen, die geplottet werden sollen
TR12_A_IN = A(2:end,6);
time = A(2:end,4);
time_string=datestr(time,'HH:MM:SS'); % Zeitvektor ist immer der gleiche

plot(time,TR11_A_IN,time,TR12_A_IN)
grid on 
set(gca, 'XTick', [time(1);time(numel(time)/2);time(end)]) % Hier wird die Verteilung der Ticks geregelt, daf?r wird der Array eingelesen, der nicht zum string konvertiert wurde
set(gca, 'XTickLabel',{time_string(1,:);time_string(numel(time)/2,:);time_string(end,:)}) % Hier wird die Bezeichnung ge?ndert, da der array 'time' im nicht lesbaren Format vorliegt

