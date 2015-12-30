function [SelectedIndex] = extractConditions(Input_RaceCourse, Input_Weather, ...
    Input_Field, Input_DistanceMin, Input_DistanceMax, Input_FieldStatus, ...
    TrainingCellArray, TrainingDoubleArray)

%for numarray
Distance = find(TrainingDoubleArray(:,11) >= double(Input_DistanceMin) & ...
                TrainingDoubleArray(:,11) <= double(Input_DistanceMax));

%for one character
Weather = find([TrainingCellArray{:, 4}] == Input_Weather);
Field = find([TrainingCellArray{:, 7}] == Input_Field);
FieldStatus = find([TrainingCellArray{:, 8}] == Input_FieldStatus);

%for two or more characters
RaceCourse = [];
for k = 1:length(TrainingCellArray)
  tmp_RaceCourse = TrainingCellArray{k, 3};
  if(strcmp(tmp_RaceCourse, Input_RaceCourse))
      RaceCourse = vertcat(RaceCourse, k);
  end  
end

SelectedIndex = [];

for i = 1: length(TrainingCellArray)
    %For char (:, 1)
    if(find(RaceCourse(:, 1) == i))
        if(find(Distance(:, 1) == i))
            %For Num, Double (1, :)
            if(find(Weather(1, :) == i))
                if(find(Field(1, :) == i))
                    if(find(FieldStatus(1, :) == i))
                        SelectedIndex = vertcat(SelectedIndex, i);
                    end
                end
            end
        end
    end
end

end