%% 1. Napíšte program, ktorý vygeneruje štvorcovú maticu náhodných čísiel z
% intervalu 20 až 100. Veľkosť matice bude zadávaná z klávesnice. Pomocou
% cyklov nastavte každý prvok matice väčší ako 50 na nulu. Výslednú maticu
% vypíšte. 
function [matrix] = thematrix()
    user_size = input("Size for the matrix? ");
    matrix = randi([20, 100], user_size, user_size);
    disp(matrix)
    for i = 1:length(matrix) % Loop over rows
        for j = 1:length(matrix) % Loop over columns        
            if matrix(i, j) > 50
                matrix(i, j) = 0;
                fprintf("Row %d Column %d and element is greater: %d \n\n", i, j, matrix(i,j))
            end
        end
    end
    return 
end

thematrix()
%% ________________________________________________________

pole = randi([1, 100], 1,20);
maximum = max(pole);
new_array = [];

for i=1:length(pole)
    maximum2 = round(maximum * 0.7);
    if pole(i) > maximum2
        new_array = [new_array, pole(i)];
        fprintf("The element in the pole %d is greater than the 70 percent of the maximum value %d, %d so element was added \n\n", pole(i), maximum2, pole(i))
    end
end

disp("The array created with the values bigger than the 70% of the elements of the pole is: " + new_array)


%_________________________________________

sum_numbers = 0;
sum_positions = 0;
counter = 0;
for j=1:length(pole)
    if mod(pole(j), 2) == 0
        sum_numbers = sum_numbers + pole(j);
        if mod(j, 2) == 0
            sum_positions = sum_positions + j;
            counter = counter + 1;
        end
    end
end

disp("The sum of the even numbers in the pole are: " + sum_numbers)
if counter ~= 0
    avg_positions = sum_positions / counter;
    disp("The average of the even positions in the even numbers are: " + avg_positions)
else
    disp("There are not even positions for the even number sumed")
end


% sum of the even numbers
% average of the even positions for these numbers.

%_________________________________________________----


for h=2:2:8-1
    disp(h)
end