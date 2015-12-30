function [Cell, Double] = readCell(C, HorseName_Input)

j = 1;

%Some values are taken regular expressions
for i = 1: length(C{2}) 
    
    RaceCourse_check = strsplit(C{2}{i}, {'\d'},'DelimiterType','RegularExpression');
    
    if(length(RaceCourse_check) == 3)
        
        HorseName{j, 1} = HorseName_Input;
        
        RaceDay{j, 1} = C{1}{i};
        
        %Split '[Tokyo]' from '4[Tokyo]5' and then put to array D (double->int)
        ProgramDay_exp  = strsplit(C{2}{i}, {'\D'},'DelimiterType','RegularExpression');
        RaceCourse_exp  = strsplit(C{2}{i}, {'\d'},'DelimiterType','RegularExpression');
        ProgramDay(j, 1) = str2double(ProgramDay_exp(2));
        RaceCourse(j, 1) = RaceCourse_exp(2);
        
        Weather{j, 1}           = C{3}{i};
        RaceNo(j, 1)        = str2double(C{4}{i});
        RaceName{j, 1}          = C{5}{i};
        HowManyHorses(j, 1) = str2double(C{7}{i});
        BlockNo(j, 1)       = str2double(C{8}{i});
        GateNo(j, 1)        = str2double(C{9}{i});
        Odds(j, 1)          = str2double(C{10}{i});
        Popularity(j, 1)    = str2double(C{11}{i});
        Order(j, 1)         = str2double(C{12}{i});
        Jockey{j, 1}            = C{13}{i};
        Handicap(j, 1)      = str2double(C{14}{i});
        
        % '[Shiba]2000'  => '[Shiba]' and '2000'
        Distance_exp    = strsplit(C{15}{i}, {'\D'},'DelimiterType','RegularExpression');
        Field_exp       = strsplit(C{15}{i}, {'\d'},'DelimiterType','RegularExpression');
        Distance(j, 1) = str2double(Distance_exp{2});
        Field{j, 1}(1) = Field_exp{1}(1);
        
        FieldStatus{j, 1} = C{16}{i};
        
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
        Proceeding{j, 1} = C{21}{i};
        
        %'38.6-36.2' => '38.6' and '36.2'
        AverageTime_exp = strsplit(C{22}{i}, {'\-'},'DelimiterType','RegularExpression');
        AvgBegin(j, 1) = str2double(AverageTime_exp{1});
        AvgLast(j, 1) = str2double(AverageTime_exp{2});
        
        Last3Farlong(j, 1) = str2double(C{23}{i});
        
        %'430(-10)' => '430'
        Heavy_exp   = strsplit(C{24}{i}, {'\('},'DelimiterType','RegularExpression');
        if(length(Heavy_exp) >= 2)
            Heavy(j, 1) = str2double(Heavy_exp{1});
            HeavyDiff_exp  = strsplit(Heavy_exp{2}, {'\)'},'DelimiterType','RegularExpression');
            HeavyDiff(j, 1) = str2double(HeavyDiff_exp{1});
        else
            Heavy(j, 1) = NaN;
            HeavyDiff(j, 1) = NaN;
        end
        
        Winner{j, 1} = C{27}{i};
        j = j + 1;
    end
end

if(j >= 2)
    
    Cell = [HorseName, RaceDay, RaceCourse, Weather, RaceName, Jockey, Field, FieldStatus, Proceeding, Winner];
    %whos Cell

    %Calculate meter per second (m/s)
    MeterperSec = NaN(length(TimeinSec), 1);
    for k = 1: length(TimeinSec)
        MeterperSec(k, 1) = Distance(k, 1)/TimeinSec(k, 1);
    end
    
    %Calculate recent 5 races mean meter per second 
    Recent5MeterperSecMEAN = NaN(length(TimeinSec), 1);
    if (length(MeterperSec) >= 5)
        for k = 1: (length(MeterperSec)-5)
            Recent5MeterperSecMEAN(k, 1) = mean(MeterperSec(k:(k+4),1), 'omitnan');
        end
    end
    
    %Calculate recent 5 races mean last 3 farlong 
    Recent5Last3FarlongMEAN = NaN(length(Last3Farlong), 1);
    if (length(Last3Farlong) >= 5)
        for k = 1: (length(Last3Farlong)-5)
            Recent5Last3FarlongMEAN(k, 1) = mean(Last3Farlong(k:(k+4),1), 'omitnan');
        end
    end
   
    %Rentai or not (1st or 2nd)
    Rentai = NaN(length(Order), 1);
    for k = 1: length(Order)
        if(Order(k, 1) == 1 || Order(k, 1) == 2)
            Rentai(k, 1) = 1;
        else
            Rentai(k, 1) = 0;
        end
    end
    
    %Calculate recent 5 races Rentai rate
    Recent5RentaiRate = NaN(length(Rentai), 1);
    if (length(Rentai) >= 5)
        for k = 1: (length(Rentai)-5)
            Recent5RentaiRate(k, 1) = mean(Rentai(k:(k+4),1));
        end
    end

    Double = [ProgramDay, RaceNo, HowManyHorses, BlockNo, GateNo,...
              Odds, Popularity, Order, Recent5RentaiRate, Handicap,...
              Distance, TimeinSec, Recent5MeterperSecMEAN, TimeGap, AvgBegin,...
              AvgLast, Last3Farlong, Recent5Last3FarlongMEAN, Heavy, HeavyDiff];
          
else
    Cell = {};
    Double = [];
end 