function [Cell, Num, Double] = readCell(C)

%Some values are taken regular expressions
% '4[Tokyo]5'  => '[Tokyo]'
for i = 1: length(C{2}) 
    %Split '[Tokyo]' from '4[Tokyo]5' and then put to array D (double->int)
    tmp1 = strsplit(C{2}{i}, {'\D'},'DelimiterType','RegularExpression');
    tmp2 = strsplit(C{2}{i}, {'\d'},'DelimiterType','RegularExpression');
    
    if(isempty(cell2mat(tmp2(1))))
        N(i, 1) = tmp1(2);
        R(i, 1) = tmp2(2);
    end
end

% '[Shiba]2000'  => '[Shiba]' and '2000'
for i = 1: length(C{14}) 
    %Split '2000' from '[Shiba]2000' and then put to array D (double->int)
    tmp1 = strsplit(C{14}{i}, {'\D'},'DelimiterType','RegularExpression');
    D(i, 1) = str2double(tmp1{2});
    
    %Split '[Shiba]' from '[Shiba]2000' and then put to array E (cell)
    tmp2 = strsplit(C{14}{i},{'\d'},'DelimiterType','RegularExpression');
    E{i, 1}(1) = tmp2{1}(1);
end

C{19}{1}

%'38.6-36.2' => '38.6' and '36.2'
for i = 1: length(C{19}) 
    tmp = strsplit(C{19}{i}, {'\-'},'DelimiterType','RegularExpression');
    F(i, 1) = str2double(tmp{1});
    G(i, 1) = str2double(tmp{2});
end

%'430(-10)' => '430'
for i = 1: length(C{21}) 
    tmp = strsplit(C{21}{i}, {'\('},'DelimiterType','RegularExpression');
    H(i, 1) = str2double(tmp{1});
end

%'2:14.9' = > '134.9'
for i = 1: length(C{16}) 
    tmp = strsplit(C{16}{i}, {':'},'DelimiterType','RegularExpression');
    minute = str2double(tmp{1});
    second = str2double(tmp{2});
    I(i, 1) = 60.0 * minute + second;
end

Cell = [C{1}, N, R, C{3}, C{5}, C{12}, C{15}, C{18}, C{22}, E];
%Char
%whos Cell

Num = [C{4}, C{6}, C{7}, C{8}, C{10}, C{11}, C{13}, int32(D), H];
%Num
%whos Num

Double = [C{9}, C{17}, I, F, G, C{20}];
%Double
%whos Double
%horseData(1).num(:,1)


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