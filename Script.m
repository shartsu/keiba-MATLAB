function [Distance, RaceCourse] = Script(Input_Weather, Input_RaceCourse, Input_Field, Input_DistanceMin, Input_DistanceMax, CellArray, NumArray) 

Distance = find(NumArray(:,2) >= Input_DistanceMin & NumArray(:,2) <= Input_DistanceMax);

Weather = find([CellArray{:, 3}] == Input_Weather);
Field = find([CellArray{:, 5}] == Input_Field);

%for Char
RaceCourse = [];
for k = 1:length(CellArray)
  tmp_RaceCourse = CellArray{k, 2};
  if(strcmp(tmp_RaceCourse, Input_RaceCourse))
      RaceCourse = vertcat(RaceCourse, k);
  end  
end

%Weather.' 
%Field.'
%RaceCourse
%Distance

for i = 1: length(CellArray)
    if(find(RaceCourse(:, 1) == i) > 0)
        j = i;
        if(find(Distance(:, 1) == j) > 0)
            j
        end
    end
end

end