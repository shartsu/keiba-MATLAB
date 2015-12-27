
directory = '1000';
d = dir(strcat(directory, '/', '*.csv'));

CellArray = zeros(1, 9);
NumArray = zeros(1, 8);
DoubleArray = zeros(1, 8);

AllData = {''};

for n = 1 : numel(d)
    
    fid = fopen(strcat(directory, '/', d(n).name),'r','n','UTF-8');
    strcat(directory, '/', d(n).name)
    
    AllData{n} = textscan(fid,'%s %s %s %d %s %s %d %d %d %s %s %s %s %d %s %s %s %s %s %s %s %s %s %s %s %s %s %s',...
'Delimiter',',', 'HeaderLines', 0, 'EmptyValue',-Inf);

    %length(AllData{n}{1})

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

%whos CellArray
%whos NumArray
%whos DoubleArray

