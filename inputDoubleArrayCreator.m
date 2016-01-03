function [InputDoubleArray] = inputDoubleArrayCreator(inputTrainingDoubleArray, atndHorseList)

%atndHorseList = [horseID, newHandicap, newHeavydiff]
for i = 1 : length(atndHorseList)
    
    atndHorseIndex = find(inputTrainingDoubleArray == atndHorseList(i, 1));
    minIndex = min(atndHorseIndex);
    
    newHandicap = atndHorseList(i, 2);
    newHeavydiff = atndHorseList(i, 3);
    
    InputDoubleArray(i,:) = [i, inputTrainingDoubleArray(minIndex,10), ...
        newHandicap, inputTrainingDoubleArray(minIndex,14),...
        inputTrainingDoubleArray(minIndex,19), newHeavydiff];
    
end