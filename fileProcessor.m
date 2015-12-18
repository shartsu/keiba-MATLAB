
d = dir('*.csv');

for n = 1 : numel(d)
    
    d(n).name
    
    fid = fopen(d(n).name,'r','n','UTF-8');
    C = textscan(fid,'%s %s %s %d %s %*q %d %d %d %f %d %d %s %d %s %s %*s %s %f %*s %s %s %f %s %*q %*s %s %*q',...
    'Delimiter',',', 'HeaderLines', 0, 'EmptyValue',-Inf);
    
    [Cell, Num, Double] = readCell(C)
    
    fclose(fid);
end