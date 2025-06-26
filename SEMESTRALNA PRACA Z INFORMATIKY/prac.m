%function which input data is a pole and the task is to sum each 
% second component in the pole 
%and calculate the avg from that quantity.

pole = [1, 2, 3, 4, 5, 6];
pole2 = [1, 5, 3, 7, 9, 6];
pole3 = [1, 2, 3, 4, 5, 6, 7, 8];

function SumofOddIndexedElements(pole)
    addition = 0;
    for i = 1: length(pole)
        if mod(i, 2) ~= 0
            addition = addition + pole(i);
        end
    end
    fprintf("The sum of the odd index elements in the pole was : %d \n", addition)
end


SumofOddIndexedElements(pole)
    % Sum every second component (every second element in the array)
%___________________________________________________________________

%Problem 2: Find the Maximum Element in Even Indices
%Write a MATLAB function that finds and returns the maximum value among the elements located at even indices (2nd, 4th, 6th, etc.) of the array pole.

function FindtheMaximumElementinEvenIndices(pole)
    max = 0;
    for i = 1: length(pole)
        if mod(i, 2) == 0
            if pole(i) > max
                max = pole(i);
            end
        end
    end
    fprintf("The maximum element in even indices in the pole: %d \n", max)
    return
end

FindtheMaximumElementinEvenIndices(pole2);

%___________________________________________________________________

% Problem 3: Extract a Subarray Based on Indexing
% Write a MATLAB function that takes an array pole 
% and two integers start_idx and end_idx as input. 
% The function should return a subarray starting 
% from start_idx and ending at end_idx (inclusive).

function [array] = ExtractaSubarrayBasedonIndexing(start_idx, end_idx, pole)
    array = pole(start_idx:end_idx);
    disp(array)
    return
end

ExtractaSubarrayBasedonIndexing(3, 6 , pole3);

%____________________________________________________________________

%Problem 4: Replace Elements Based on Condition
%Write a MATLAB function that replaces all elements at 
%odd indices in the array pole with a value X. Return the modified array.


function ReplaceElementsBasedonCondition(x, pole)
    for i = 1: length(pole)
        if mod(i, 2) ~= 0
            pole(i) = x;
        end
    end
    disp(pole)
end

ReplaceElementsBasedonCondition(100, pole)
% pole = [1, 2, 3, 4, 5, 6] and X = 100, 
% the function should return [100, 2, 100, 4, 100, 6].




