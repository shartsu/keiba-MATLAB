function readCSV(RaceCSV)

fid = fopen(RaceCSV,'r','n','UTF-8');
C = textscan(fid,'%s %s %s %d %s %*q %d %d %d %f %d %d %s %d %s %s %*s %s %f %*s %s %s %f %s %*q %*s %s %*q',...
    'Delimiter',',', 'HeaderLines', 0, 'EmptyValue',-Inf);
fclose(fid);


celldisp(C)


Char = [C{1}, C{2}, C{3}, C{5}, C{12}, C{14}, C{15}, C{16}, C{18}, C{19}, C{21}, C{22}];
Char
whos Char


Num = [C{4}, C{6}, C{7}, C{8}, C{10}, C{11}, C{13}];
Num
whos Num

Double = [C{9}, C{17}, C{20}];
Double
whos Double

%{
figure
plot(DoubleArray(:,6), DoubleArray(:,1),'-o');
axis([0,4,1,18]);


ax = gca;
hold all;
set(gca,'XTick',0:0.25:4);
set(gca,'YTick',1:1:18);
set(gca,'XGrid','on','YGrid','on');
ax.YTickLabel = CharArray;
%}
end