function readXLS(RaceXLS)
RaceDATA = importdata(RaceXLS);
CellArray = RaceDATA(30:47, 37:47);

for i = 1:18
    %Column 1 GoalOrder
    col1 = CellArray(i,1);
    col1Char= cell2mat(col1);
    DoubleArray(i,1) = str2double(col1Char);
    
    %Column 3 HorseName
    col3 = CellArray(i,3);
    col3Char = cell2mat(col3);
    CharArray(i,1) = cellstr(col3Char);
    
    %Column 6 GoalTimeDelay
    col6 = CellArray(i,6);
    col6Char = cell2mat(col6);
    DoubleArray(i,6) = str2double(col6Char);
    if(isnan(DoubleArray(i,6))) DoubleArray(i,6) = 0; end
end

whos DoubleArray
whos CharArray

figure
plot(DoubleArray(:,6), DoubleArray(:,1),'-o');
axis([0,4,1,18]);

ax = gca;
hold all;
set(gca,'XTick',0:0.25:4);
set(gca,'YTick',1:1:18);
set(gca,'XGrid','on','YGrid','on');
ax.YTickLabel = CharArray;
end