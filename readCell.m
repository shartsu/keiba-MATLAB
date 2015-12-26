function [Cell, Num, Double] = readCell(C)

j = 1;

%Some values are taken regular expressions
for i = 1: length(C{2}) 
    
    RaceCourse_check = strsplit(C{2}{i}, {'\d'},'DelimiterType','RegularExpression');
    %RaceCourse_check
    
    if(length(RaceCourse_check) == 3)
        RaceDay{j, 1} = C{1}{i};
        
        %Split '[Tokyo]' from '4[Tokyo]5' and then put to array D (double->int)
        ProgramDay_exp  = strsplit(C{2}{i}, {'\D'},'DelimiterType','RegularExpression');
        RaceCourse_exp  = strsplit(C{2}{i}, {'\d'},'DelimiterType','RegularExpression');
        ProgramDay(j, 1) = str2double(ProgramDay_exp(2));
        RaceCourse(j, 1) = RaceCourse_exp(2);
        
        Weather{j, 1} = C{3}{i};
        RaceNo(j, 1) = C{4}(i);
        RaceName{j, 1} = C{5}{i};
        HowManyHorses(j, 1) = C{7}(i);
        BlockNo(j, 1) = C{8}(i);
        GateNo(j, 1) = C{9}(i);
        Odds(j, 1) = str2double(C{10}{i});
        Popularity(j, 1) = str2double(C{11}{i});
        Order(j, 1) = str2double(C{12}{i});
        Jockey{j, 1} = C{13}{i};
        Handicap(j, 1) = C{14}(i);
        
        % '[Shiba]2000'  => '[Shiba]' and '2000'
        Distance_exp    = strsplit(C{15}{i}, {'\D'},'DelimiterType','RegularExpression');
        Field_exp       = strsplit(C{15}{i}, {'\d'},'DelimiterType','RegularExpression');
        Distance(j, 1) = str2double(Distance_exp{2});
        Field{j, 1}(1) = Field_exp{1}(1);
        
        FieldStatus(j, 1) = C{16}(i);
        
        %'2:14.9' = > '134.9'
        TimeinSec_exp   = strsplit(C{18}{i}, {':'},'DelimiterType','RegularExpression');
        if(length(TimeinSec_exp) >= 2)
            minute = str2double(TimeinSec_exp{1});
            second = str2double(TimeinSec_exp{2});
            TimeinSec(j, 1) = 60.0 * minute + second;
        else
            TimeinSec(j, 1) = NaN;
        end
        
        TimeGap(j, 1) = str2double(C{19}{i});
        Proceeding(j, 1) = C{21}(i);
        
        %'38.6-36.2' => '38.6' and '36.2'
        AverageTime_exp = strsplit(C{22}{i}, {'\-'},'DelimiterType','RegularExpression');
        AvgBegin(j, 1) = str2double(AverageTime_exp{1});
        AvgLast(j, 1) = str2double(AverageTime_exp{2});
        
        Last3Halon(j, 1) = str2double(C{23}{i});
        
        %'430(-10)' => '430'
        Heavy_exp   = strsplit(C{24}{i}, {'\('},'DelimiterType','RegularExpression');
        Heavy(j, 1) = str2double(Heavy_exp{1});

        Winner{j, 1} = C{27}{i};
        j = j + 1;
    end    

end

if(j >= 2)
    Cell = [RaceDay, RaceCourse, Weather, RaceName, Field, FieldStatus, Jockey, Proceeding, Winner];
    %Char
    %whos Cell

    Num = [int32(ProgramDay), int32(Distance), RaceNo, HowManyHorses, BlockNo, GateNo, Handicap, Heavy];
    %Num
    %whos Num

    Double = [Odds, Popularity, Order, TimeGap, TimeinSec, AvgBegin, AvgLast, Last3Halon];
    %Double
    %whos Double
    %horseData(1).num(:,1)
else
    Cell = {};
    Num = [];
    Double = [];
end 

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