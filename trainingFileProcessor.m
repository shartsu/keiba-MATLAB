function [TrainingDoubleArray, TrainingCellArray] = trainingFileProcessor(directory)

d = dir(strcat(directory, '/', '*.csv'));

TrainingCellArray = {};
TrainingDoubleArray = [];
AllData = {};

for n = 1 : numel(d)
    
    fid = fopen(strcat(directory, '/', d(n).name),'r','n','UTF-8');
    
    HorseName = strsplit(d(n).name, {'\d'},'DelimiterType','RegularExpression');
    HorseID = strsplit(d(n).name, {'\D'},'DelimiterType','RegularExpression');
    strcat(directory, '/', d(n).name)
    
    AllData{n} = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',...
'Delimiter',',', 'HeaderLines', 0);

    [TmpCell, TmpDouble] = readCell(AllData{n}, HorseName{1, 2}, HorseID(1, 1));

    if(n == 1)
        TrainingCellArray = TmpCell;
        TrainingDoubleArray  = TmpDouble;
    else
        TrainingCellArray = vertcat(TrainingCellArray, TmpCell);
        TrainingDoubleArray  = vertcat(TrainingDoubleArray , TmpDouble);
    end
    
    fclose(fid);
end

end
