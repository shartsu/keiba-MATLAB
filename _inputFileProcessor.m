function [InputDoubleArray] = inputFileProcessor(directory, newHandicap, newHeavydiff)

d = dir(strcat(directory, '/', '*.csv'));

InputDoubleArray = [];
AllData = {};

for n = 1 : numel(d)
    
    fid = fopen(strcat(directory, '/', d(n).name),'r','n','UTF-8');
    
    HorseName = strsplit(d(n).name, {'\d'},'DelimiterType','RegularExpression');
    strcat(directory, '/', d(n).name)
    
    AllData{n} = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',...
'Delimiter',',', 'HeaderLines', 0);

    [TmpCell, TmpDouble] = readCell(AllData{n}, HorseName{1, 2});
    
    InputDoubleArray(n,:) = [n, TmpDouble(1,9), newHandicap(n,1), ...
        TmpDouble(1,13) TmpDouble(1,18), newHeavydiff(n, 1), ];
   
    fclose(fid);
end

end
