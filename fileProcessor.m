
directory = '1000';
d = dir(strcat(directory, '/', '*.csv'));

CellArray = zeros(1, 9);
NumArray = zeros(1, 9);
DoubleArray = zeros(1, 6);

for n = 1 : numel(d)
    
    fid = fopen(strcat(directory, '/', d(n).name),'r','n','UTF-8');
    strcat(directory, '/', d(n).name)
    
    AllData{n} = textscan(fid,'%s %s %s %d %s %*q %d %d %d %f %d %d %s %d %s %s %*s %s %f %*s %s %s %f %s %*q %*s %s %*q',...
'Delimiter',',', 'HeaderLines', 0, 'EmptyValue',-Inf);

    [Cell, Num, Double] = readCell(AllData{n});

    if(n == 1)
        CellArray = Cell;
        NumArray = Num;
        DoubleArray = Double;
    else
        CellArray = vertcat(CellArray, Cell);
        NumArray = vertcat(NumArray, Num);
        DoubleArray = vertcat(DoubleArray, Double);
    end
    
    fclose(fid);
end

whos CellArray
whos NumArray
whos DoubleArray

