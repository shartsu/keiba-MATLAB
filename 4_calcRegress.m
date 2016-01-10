function [regressRESULT] = calcRegress(TrainingDoubleArray, SelectedIndex, InputDoubleArray)

%y = TimeinSec
y = TrainingDoubleArray(SelectedIndex, 13);
one = ones(length(SelectedIndex), 1);
%X = GateNo, Recent5RentaiRate, Handicap
%    Recent5MeterperSecMEAN, Recent5Last3FarlongMEAN, HeavyDiff, Recent5DistanceMEAN
X = [one, TrainingDoubleArray(SelectedIndex, 6), TrainingDoubleArray(SelectedIndex, 10),...
    TrainingDoubleArray(SelectedIndex, 11), TrainingDoubleArray(SelectedIndex, 14),...
    TrainingDoubleArray(SelectedIndex, 19), TrainingDoubleArray(SelectedIndex, 21),...
    TrainingDoubleArray(SelectedIndex, 22)];

[b,bint,r,rint,stats] = regress(y, X);
b

regressRESULT = [length(InputDoubleArray(:, 1)), 1];

for i = 1: length(InputDoubleArray)
    
    regressRESULT(i, 1) = b(2, 1) * InputDoubleArray(i, 1) + ...
                    b(3, 1) * InputDoubleArray(i, 2) + ...
                    b(4, 1) * InputDoubleArray(i, 3) + ...
                    b(5, 1) * InputDoubleArray(i, 4) + ...
                    b(6, 1) * InputDoubleArray(i, 5) + ...
                    b(7, 1) * InputDoubleArray(i, 6) + ...
                    b(8, 1) * InputDoubleArray(i, 7) + ...
                    b(1, 1); 
                
    regressRESULT(i, 2) = i;
end

sortrows(regressRESULT)

end