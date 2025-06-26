 % SEMESTRALNA PRACA - CESAR SANTIAGO GONZALEZ CUELLAR - 3IEZ10 - FEIT -
% KOMUNICACNE A INFORMACNE TECHNOLOGII.
% Column 1: Month, Column 2: Day, Column 3: Hour, Column 4: Minute, Column
% 5: Temperature, Column. 6: Humidity, Column. 7: Wind speed, Column. 8: Wind direction,
% Column. 9: Pressure, Column. 10: Solar radiation

%_______________________________________________________________________________________________________________________________________________________________________

% Loading the data into a variable = meteodata 
main()
% The main function is in charge of connecting the rest of the functions along the code.
function main()
    % Load data inside the main function (DATA MUST BE CHARGE INSIDE THE MAIN FUNCTION SINCE WE JUST WANT TO USE IT INSIDE THE FUNCTIONS THAT ARE IN THE MAIN.)
    load("meteodata.mat", "meteodata");

    % Ask what the user wants to get the value from the data.
    user_decision = 0;
    while user_decision ~= 1 && user_decision ~= 2 && user_decision ~= 3 && user_decision ~= 4 && user_decision ~= 5 % Compare with users answer until user gives a valid answer.
        user_decision = input("Choose an option: \n | 1. Full month\n | 2. Specific day in a Month \n | 3. Range of days in a month \n | 4. Monthly functions \n | 5. Daily function \n | Your choice: ");
    end

    % Retrieve the month
    month = retrieve_month_from_user();
    
    switch user_decision
        case 1
            % Full month and retrieve the value user wants to work with.
            retrieved_value = retrieve_value_from_user();
            % Let the user know the data that was matched.
            %% printdata_Month(meteodata, month, retrieved_value);
            % Shows user the type of data that he can retrieved from this.
            month_statistics(meteodata, month, retrieved_value) 
%% PRVA ULOHA 1. Average temperature from the month 

        case 2
            % Specific day
            day = check_for_input_validity_month_days(month);
            % Retrieve the value user wants to work with once checked the month matches the day user wants data from.
            retrieved_value = retrieve_value_from_user();
            % Let the user know the data that was matched.
            %% printdata_from_day_per_Month(meteodata, month, day, retrieved_value);
            % Shows user the data that he retrieved from this.
            day_month_statistics(meteodata, month, day, retrieved_value)

        case 3
            % Range of days
            [from_day, to_day] = retrieve_range_from_user();
            retrieved_value = retrieve_value_from_user();
            % Let the user know the data that was matched.
            range_month_statistics(meteodata, month, from_day ,to_day, retrieved_value)
            %% printdata_from_day_per_Month(meteodata, month, day, retrieved_value);
            % Shows user the data that he retrieved from this.
        case 4
            main2(meteodata, month)
        case 5
            main3(meteodata, month)
            
    end

    
end

%% Function to retrieve month
function value_month = retrieve_month_from_user()
    value_month = 0;
    while value_month < 1 || value_month > 12 || isempty(value_month) % not empty user's answer, a between range for months in a year since the data does not have more than 1 year
        value_month = input("Enter the month number taking into account 1 for January, 12 for December : ");
    end
end

%% _________________________________________Function to retrieve the value INPUT )_____________________________________
function value_user_input = retrieve_value_from_user() % retrieve the value from the user
    value_user_input = 0;
    while value_user_input < 1 || value_user_input > 7
        value_user_input = input("Which value would you like to retrieve, respectively choose the number besides the variable: \n " + ...
            "| 1. Temperature\n | 2. Humidity\n | 3. Wind speed\n | 4. Wind direction\n | 5. Pressure\n | 6. Solar radiation\n --> Your choice: ");
        
    end
end

%% _________________________________________Function to retrieve a valid day for the given month____________________________________________________
function retrieved_day = check_for_input_validity_month_days(month) % Check if the input is valid

    days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; 
    % Define the limit day for the user's month's answer, the user gave 12,
    % so we have in our array that index --> 12 is 31. which is the new
    % limit
    limit_day = days_in_month(month);
    retrieved_day = 0;
    while retrieved_day < 1 || limit_day  < retrieved_day %% Evaluate if the day is inside the range
        retrieved_day = input("Enter a valid day for the selected month: ");
        if retrieved_day > limit_day
            disp("The selected month only has " + limit_day + " days.");
        end
    end
end

%% ________________________________________Function to retrieve a range of days_____________________________________________________________________
function [from_day, to_day] = retrieve_range_from_user()
    from_day = 0;
    to_day = 0;
    while from_day < 1 || to_day < 1 || from_day > to_day
        from_day = input("Enter from which day: ");
        to_day = input("Enter to which day: ");
        if from_day > to_day
            disp("Start day must be less than or equal to end day.");
        end
    end
end

%% ___________________________PRINT_DATA- SELF DEBUGGING______________________________________
%% Print data for a full month
%function printdata_Month(data, month, from_user_value_type_month)
% Function gets the month value and the value user wanted to get, which we pass to the seeking_value_in_month
   % month_values = seeking_value_in_month(data, month, from_user_value_type_month);
    %disp("Data for month " + month + ":");
    %disp(month_values);
%end

%% Print data for a specific day in a month
% function printdata_from_day_per_Month(data, month, day, retrieved_value_type_specificday)
%     day_month_values = seeking_value_in_day_per_month(data, month, day, retrieved_value_type_specificday);
%     disp("Data for month " + month + ", day " + day + ":");
%     disp(day_month_values);
% end

%% Print data for a range of days in a month
% function printdata_in_range_month(data, month, from_day, to_day, from_user_value_type_rangedays)
%     values = seeking_value_in_range_per_month(data, month, from_day, to_day, from_user_value_type_rangedays);
%     disp("Data for month " + month + ", from day " + from_day + " to day " + to_day + ":");
%     disp(values);
% end


%% _________________________________RETRIEVE_DATA___________________________
%% Mathlab : ELEMENT WISE OPERATORS A & B performs a logical AND of inputs A and B and returns an array or a table containing elements set to either logical 1 (true) or logical 0 (false). An element of the output is set to logical 1 (true) if both A and B contain a nonzero element at that same location
%% Retrieve values for a full month
function values = seeking_value_in_month(data, month, from_user_value_type_month)
    % user can only have until 5, and we have ten rows, since minimum value
    % for user is 1, then we want to retrieve temperature for example which is 5 so we sum 4 to this value.
    from_user_value_type_month = from_user_value_type_month + 4;
    month_values = data(:, 1) == month;
    values = data(month_values, from_user_value_type_month);
end

%% Retrieve values for a specific day in a month
function values = seeking_value_in_day_per_month(data, user_month, day, from_user_value_type_specificday)
    % data(n,m) where n is all the rows in the m columns.
    % for user is 1, then we want to retrieve temperature for example which is 5 so we sum 4 to this value.
    from_user_value_type_specificday = from_user_value_type_specificday + 4; 
    month_rows = data(:, 1) == user_month;
    days_rows = data(:, 2) == day;
    month_day_values = days_rows & month_rows;
    values = data(month_day_values, from_user_value_type_specificday);
end

%% Retrieve values for a range of days in a month
function values = seeking_value_in_range_per_month(data, user_month, from_day, to_day, from_user_value_type_rangedays)
    from_user_value_type_rangedays = from_user_value_type_rangedays + 4;
    month_rows = data(:, 1) == user_month;
    range_rows = data(:, 2) >= from_day & data(:, 2) <= to_day;
    month_range_values = month_rows & range_rows;
    values = data(month_range_values, from_user_value_type_rangedays);
end

%% Function redefines the value for the output to the user, since it may not
% remember what it was asking for.

function month_statistics(data, month, user_value_type_month)
    days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    month_days = days_in_month(month);
    % Array for the possible values
    array_value = ["Temperature in (Degrees Celsius)", "Humidity in percentage (%)", "Wind speed in (Meters/seconds)", "Wind direction in (degrees)", "Pressure in (hPA)", "Solar radiation in (w/mts^2)"];
    % Array for the possible months
    array_months = ["January","February","March", "April","May","June","July","Augost","September","Octuber","November","December"];

    month_values = seeking_value_in_month(data, month, user_value_type_month);

    if isempty(month_values)
        disp("No data available for the selected month and value type.");
        return;
    end
    
    % Redefine the month from number as the name.
    month = array_months(month);
    
    % Redefine the value from number as the name.
    user_value_type_month = array_value(user_value_type_month);
    [labelx, labely, typegraph] = typegraphs(array_value, user_value_type_month);
    % Average VALUE per month
    value_mean = mean(month_values);
    % Display the AVG info to the user (without graf)
    %disp(month_values)
    %disp(length(month_values))
    fprintf("Average %s for %s is %.2f \n", user_value_type_month, month, value_mean)
    
    % The maximum value by month
    value_max = max(month_values);
    % Display the MAX info to the user (without graf)
    fprintf("Maximum %s for %s is %.2f \n", user_value_type_month, month, value_max)

    % The minimum value by month
    value_min = min(month_values);
    % Display the info to the user (without graf)
    fprintf("Minimum %s for %s is %.2f \n", user_value_type_month, month, value_min)


    
    % Query points towards which the interpolarization will be throw
    % month_in_days = linspace(1, month_days, month_days); % Vector from one to size(month) user chose, splited in month_days value. which means 1 day per 1 day would be the x axis
    % Split the month into the same amount of values in terms of hours days -> 1 day so those days splited in the length of day_month_values. % Split for matching each the noded variables, original hours, and with a value, but between the range of the days user chose.
    month_in_values = linspace(1, month_days, length(month_values));
    % Interpolating day_in_values and day_month_values are vectors of equal length, reason why we can now interpolate the interpolated_day_month_values to be the same size as original_hours.
    % interpolated_month_values = interp1(month_in_values, month_values, month_in_days);
    % day_in_hours same vector size as interpolated_day_month_values
    figure;
  
    % plot(month_in_values, month_values, "-") % Line plot for dat
    switch typegraph
        case 1
            figure; % Create a new figure
            plot(month_in_values, month_values,  "-") % Line plot for data
            hold on;
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
            
        case 2
            figure; % Create a new figure
            bar(month_in_values , month_values) % Line bars for data
            hold on;
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 4); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 4); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 4); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
        case 3
            figure; % Create a new figure
            hold on;
            plot(month_in_values, month_values,  "r", LineWidth=1.5) % Line plot for data
            bar(month_in_values, month_values,  "b") % Line bars for data
            
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 4); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 4); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 4); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
        case 4
            img = imread("directionofwind.png");
            figure; % Create a new figure
            imshow(img)
            axes.position = [0 10 2 3];
            % Line plot for data
            plot(month_in_values, month_values, 'o', 'MarkerSize', 6, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');  % 'o' for circle markers
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 4); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 4); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 4); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            
            savephoto(labely)
            
     
    end
end
function savephoto(labely)
    filename = strcat(labely, '_Graph.png');
    % Save the graph
    saveas(gcf, filename);
    % Display a message
    disp(['Graph saved as ', filename]); 
end

function day_month_statistics(data, month, day, user_value_type_month)
    % Array for the possible values
    array_value = ["Temperature in (Degrees Celsius)", "Humidity in percentage (%)", "Wind speed in (Meters/seconds)", "Wind direction in (degrees)", "Pressure in (hPA)", "Solar radiation in (w/mts^2)"];
    % Array for the possible months
    array_months = ["January","February","March", "April","May","June","July","Augost","September","Octuber","November","December"];
    

    day_month_values = seeking_value_in_day_per_month(data, month, day,user_value_type_month);

    if isempty(day_month_values)
        disp("No data available for the selected month and value type.");
        return;
    end
    
    % Redefine the month and value from number as the name.
    month = array_months(month);
    user_value_type_month = array_value(user_value_type_month); 
    [labelx, labely, typegraph] = typegraphs(array_value, user_value_type_month);
    % Redefine the value from number as the name.
    value_mean = mean(day_month_values); % Average VALUE per month
    fprintf("Average %s for %s in the %d is %.2f \n", user_value_type_month, month, day, value_mean) % Display the AVG info to the user (without graf)
    value_max = max(day_month_values); % The maximum value by month
    fprintf("Maximum %s for %s in the %d is %.2f \n", user_value_type_month, month, day, value_max) % Display the MAX info to the user (without graf)
    value_min = min(day_month_values); % The minimum value by month
    fprintf("Minimum %s for %s in the %d is %.2f \n", user_value_type_month, month, day, value_min) % Display the info to the user (without graf)

    
    % Query points towards which the interpolarization will be throw
    % day_in_hours = linspace(1, 24, length(1:24)); 
    % Split the day into the same amount of values in terms of hours 24h -> 1 day so those 24 h splited in the length of day_month_values. % Split for matching each the noded variables, original hours, and day_month_values with a value, but between the range of the days user chose.
    day_in_values = linspace(1, 24, length(day_month_values));    
    % Interpolating day_in_values and day_month_values are vectors of equal length, reason why we can now interpolate the interpolated_day_month_values to be the same size as original_hours.
    % interpolated_day_month_values = interp1(day_in_values, day_month_values, day_in_hours);
    % day_in_hours same vector size as interpolated_day_month_values
    
    % plot(day_in_values, day_month_values, "-") % Line plot for dat
    switch typegraph
        case 1
            figure; % Create a new figure
            plot(day_in_values, day_month_values,  "-") % Line plot for data
            hold on;
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
        case 2
            figure; % Create a new figure
            bar(day_in_values , day_month_values) % Line bars for data
            hold on;
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
        case 3
            figure; % Create a new figure
            hold on;
            plot(day_in_values, day_month_values,  "r", LineWidth=1.5) % Line plot for data
            bar(day_in_values, day_month_values,  "b") % Line bars for data
            
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
        case 4
            img = imread("directionofwind.png");
            figure; % Create a new figure
            imshow(img)
            axes.position = [0 10 2 3];
            % Line plot for data
            plot(day_in_values, day_month_values, 'o', 'MarkerSize', 6, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');  % 'o' for circle markers
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
     
    end

end

function range_month_statistics(data, month, from_day, to_day,user_value_type_month)
    % Array for the possible values
    array_value = ["Temperature in (Degrees Celsius)", "Humidity in percentage (%)", "Wind speed in (Meters/seconds)", "Wind direction in (degrees)", "Pressure in (hPA)", "Solar radiation in (w/mts^2)"];
    % Array for the possible months
    array_months = ["January","February","March", "April","May","June","July","Augost","September","Octuber","November","December"];

    range_month_values = seeking_value_in_range_per_month(data, month, from_day, to_day, user_value_type_month);

    if isempty(range_month_values)
        disp("No data available for the selected month and value type.");
        return;
    end
    
    % Redefine the month and value from number to the name.
    month = array_months(month);
    user_value_type_month = array_value(user_value_type_month);
    [labelx, labely, typegraph] = typegraphs(array_value, user_value_type_month);
    % Average VALUE per month % The maximum value by month % The minimum value by month
    value_mean = mean(range_month_values);
    value_max = max(range_month_values);
    value_min = min(range_month_values);
    % Display the data
    fprintf("Average %s for %s from day %d to the %d day is %.2f \n", user_value_type_month,  month, from_day, to_day ,value_mean)
    fprintf("Maximum %s for %s from day %d to the %d day is %.2f \n", user_value_type_month, month, from_day, to_day, value_max)
    fprintf("Minimum %s for %s from day %d to the %d day is %.2f \n", user_value_type_month, month, from_day, to_day, value_min)

    % dims = size(range_month_values);
    % if all(dims == 1)
    %     disp("Scalar");
    %  THIS CODE WAS FOR DEBUGGING
    % elseif dims(1) == 1 || dims(2) == 1
    %     disp("Vector");
    %     disp(length(range_month_values))
    % else
    %     disp("Matrix");
    % end

    % Generate days for x-axis 
    % days_linspace = linspace(from_day, to_day, length(from_day:to_day)); % QUERY POINTS
    % Split the range of days into the same amount of values there are.
    day_in_values = linspace(from_day, to_day, length(range_month_values)); % ALIGN VALUES WITH RANGE OF TIME. so each value has time connection.
    % Interpolate for matchinig each day with a value, but between the range of the days user chose.
    % INTERP1 = Where x, y, z are the parameters, x and y are the same size vector, and then we match both x and y, in regards to the query points Z, which are the bigger points towards which the data will relate to. Interpolation is mostly used to find values in an array that dont exist but can have an approximation, if we have another related array
    % interpolar_range_month_values = interp1(day_in_values, range_month_values, days_linspace); 
    
    switch typegraph
        case 1
            figure; % Create a new figure
            plot(day_in_values, range_month_values,  "-") % Line plot for data
            hold on;
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
        case 2
            figure; % Create a new figure
            bar(day_in_values , range_month_values) % Line bars for data
            hold on;
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
        case 3
            figure; % Create a new figure
            hold on;
            plot(day_in_values, range_month_values,  "r", LineWidth=1.5) % Line plot for data
            bar(day_in_values, range_month_values,  "b") % Line bars for data
            
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
        case 4
            img = imread("directionofwind.png");
            figure; % Create a new figure
            imshow(img)
            axes.position = [0 10 2 3];
            % Line plot for data
            plot(day_in_values, range_month_values, 'o', 'MarkerSize', 6, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');  % 'o' for circle markers
            % Display the values in the same plotting
            yline(value_mean,  '--k', 'DisplayName', sprintf('Average (%.2f)', value_mean), "LineWidth", 2.5); % Average line
            yline(value_max, '--g', 'DisplayName', sprintf('Maximum (%.2f)', value_max), "LineWidth", 2.5); % Max line
            yline(value_min, '--b', 'DisplayName', sprintf('Minimum (%.2f)', value_min), "LineWidth", 2.5); % Min line
            legend("Average(black)| Maximum(green) | Minimum(blue) "+ user_value_type_month + " ")
            xlabel(labelx);
            ylabel(labely);
            hold off
            grid on;
            savephoto(labely)
     
    end

    

end

%% ____
% _______________________________________ALL THE FUNCTIONS GETTING THE VALUES AVERAGE, MIN, AND MAX FOR THE MONTH, DAY AND RANGE OF DAYS______________________

function main2(data, month) % Monthly statistics functions
    
% Since we didnt have any clear patters for making functions usable for
% several inputs, we will do it manually, which i personally think is not
% recommended for any job and either used.
    user_decision2 = input("Which function would you like get? \n | 1. The hottest day in the month (according to the 10 hottest hours.) \n | " + ...
        "2. Sort days for a given month by sunshine (Sunshine).\n | 3. Sort days for a given month by humidity. \n" + ...
        " | 4. Sort days for a given month by pressure.\n | 5. Sort days for a given month by wind speed. \n --> Your choice: ");

    switch user_decision2
        case 1
            first(data, month)
            return
        case 2
            second(data, month)
            return
        case 3
            third(data, month)
            return
        case 4
            forth(data, month)
            return
        case 5
            fifth(data, month)
            return

    end

    function first(inside_data, inside_month)
         % 1. The hottest day in the month (according to the 10 hottest hours.) 
         
         % I could not understand the logic under this, although it was almost the same as the rest
    end

    function second(inside_data, inside_month) % 2. Sort days for a given month by sunshine (Sunshine).
        
        month_value = inside_month; % Get the month
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        values = inside_data(:, 10);
        days = inside_data(:, 2);
        limit_day = days_in_month(month_value);
        
        average_values = zeros(1, limit_day);
         % Loop through each unique day
        for day=1:limit_day
            % Get the first, second, third, forth... day
            % Get all the values for that day when you use a logical array to index into another array, it selects the elements from the second array
            day_values = values(days == day);
            avg_value = mean(day_values);  % Calculate the average of the values for this day
            average_values(day) = avg_value;
        end  
        [sorted_avg_values, sorted_index] = sort(average_values, 'descend');
        sorted_days = 1:limit_day;  % Days from 1 to limit_day
        sorted_days = sorted_days(sorted_index);  % Sort the days by the sorted average values
        % Get the average value for each day
        fprintf("Sort days from the highest to the lowest for a given month by sunshine is \n")
        for j=1:length(sorted_days)
            disp("______________________")
            disp(j + ". day --> " + sorted_days(j) + " and value rounded is " + sorted_avg_values(j) + " in (w/mts^2)")
        end
        

    end
    function third(inside_data, inside_month)
        % 3. Sort days for a given month by humidity. \n
        
        month_value = inside_month; % Get the month
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        values = inside_data(:, 6);
        days = inside_data(:, 2);
        limit_day = days_in_month(month_value);
        
        average_values = zeros(1, limit_day);
         % Loop through each unique day
        for day=1:limit_day
            % Get the first, second, third, forth... day
            % Get all the values for that day when you use a logical array to index into another array, it selects the elements from the second array
            day_values = values(days == day);
            avg_value = mean(day_values);  % Calculate the average of the values for this day
            average_values(day) = avg_value;
        end  
        [sorted_avg_values, sorted_index] = sort(average_values, 'descend');
        sorted_days = 1:limit_day;  % Days from 1 to limit_day
        sorted_days = sorted_days(sorted_index);  % Sort the days by the sorted average values
        % Get the average value for each day
        fprintf("Sort days from the highest to the lowest for a given month by humidity is \n")
         for j=1:length(sorted_days)
            disp("______________________")
            disp(j + ". day --> " + sorted_days(j) + " and value rounded is " + sorted_avg_values(j) + " in percentage (%)")
        end
    end
    
    function forth(inside_data, inside_month)
        % 4. Sort days for a given month by pressure.
        month_value = inside_month;
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        values = inside_data(:, 9);
        days = inside_data(:, 2);
        limit_day = days_in_month(month_value);
        
        average_values = zeros(1, limit_day);
         % Loop through each unique day
        for day=1:limit_day
            % Get the first, second, third, forth... day
            % Get all the values for that day when you use a logical array to index into another array, it selects the elements from the second array
            day_values = values(days == day);
            average_value = mean(day_values);  % Calculate the average of the values for this day
            average_values(day) = average_value;
        end  
        [sorted_avg_values, sorted_index] = sort(average_values, 'descend');
        sorted_days = 1:limit_day;  % Days from 1 to limit_day
        sorted_days = sorted_days(sorted_index);  % Sort the days by the sorted average values
        % Get the average value for each day
        fprintf("Sort days from the highest to the lowest for a given month by pressure is \n")
         for j=1:length(sorted_days)
            disp("______________________")
            disp(j + ". day --> " + sorted_days(j) + " and value rounded is " + sorted_avg_values(j) + " in (hPA)")
        end
    end
    function fifth(inside_data, inside_month)
        % 5. Sort days for a given month by wind speed.
        
        month_value = inside_month; % Get the month
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        values = inside_data(:, 7);
        days = inside_data(:, 2);
        limit_day = days_in_month(month_value);
        
        average_values = zeros(1, limit_day);
         % Loop through each unique day
        for day=1:limit_day
            % Get the first, second, third, forth... day
            % Get all the values for that day when you use a logical array to index into another array, it selects the elements from the second array
            day_values = values(days == day);
            avg_value = mean(day_values);  % Calculate the average of the values for this day
            average_values(day) = avg_value;
        end  
        [sorted_avg_values, sorted_index] = sort(average_values, 'descend');
        sorted_days = 1:limit_day;  % Days from 1 to limit_day
        sorted_days = sorted_days(sorted_index);  % Sort the days by the sorted average values
        % Get the average value for each day
        fprintf("Sort days from the highest to the lowest for a given month by wind speed is rounded \n")
         for j=1:length(sorted_days)
            disp("______________________")
            disp(j + ". day --> " + sorted_days(j) + " and value rounded is " + sorted_avg_values(j) + " in (Meters/seconds)")
        end
    end


end

function main3(main3_data, main3_month) % Daily statistics functions
% Since we didnt have any clear patters for making functions usable for
% several inputs, we will do it manually, which i personally think is not
% recommended for any job and either used.
    user_decision3 = input("| 1. The hottest hour. \n| 2. The sunniest hour \n| 3. the most humed hour \n| 4. The highest wind speed \n --> Your choice: ");
    
    switch user_decision3
        case 1
            % 1. The hottest hour temperature(5)
            first(main3_data, main3_month)
        case 2
            % 2. The sunniest hour (solar radiation-10). n
            second(main3_data, main3_month)
        case 3
            % 3. the most humed hour humidity (6)
            third(main3_data, main3_month)
        case 4
            % 4. The most brighten hour (solar radiation-10). n
            forth(main3_data, main3_month)
    end
    function first(data, month)
        array_months = ["January","February","March", "April","May","June","July","Augost","September","Octuber","November","December"];
        month_print = array_months(month);
        % 1. The hottest hour temperature(5)
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        limit_day = days_in_month(month);
        hours_in_day = 24;
        % minutes_per_hour = 60;
        values_temperature = data(:, 5);
        storing_values_per_days = zeros(1, limit_day);
        hottest_hour = 0;
        hottest_day = 0;
        max_temperature = 0;

        for day=1:limit_day % limit day values for a day creation
            storing_values_per_hour = zeros(1, hours_in_day);
            for hour=1:hours_in_day % 24 values for a day creation
                % Skips all the rows for previous days. -> (day - 1) * minutes in a day | 
                % Skips all the rows for hours within the current day.%( hour − 1 ) × 60 (hour−1)×60:
                % 59 because minutes_per_hour is 60, but we start counting from 1
                start_index = (day - 1) * 1440 + (hour - 1) * 60 + 1;
                final_index = start_index + 59;  

                % Get the values for each hour from the indexing
                % calculations made.
                values_from_hour = values_temperature(start_index:final_index);
                % Take the average temperature for the hours values gotten
                % from the indexing
                average_hour_temperature = mean(values_from_hour);

                % Compare the values and evaluate for every interval of 60
                % minutes, and if that was bigger that the last one set it
                % to the new one, then as a consecuence also the day
                if average_hour_temperature > max_temperature
                    max_temperature = average_hour_temperature;
                    hottest_hour = hour;
                    hottest_day = day;
                    
                end
                
                % Store values per hour, once taken the average from it.
                storing_values_per_hour(hour) = average_hour_temperature;
                % fprintf("Value for the %d day for the hour %d is %.2f", day, hour, average_hour_temperature)
            end
            
            % Calculate and store daily average
            storing_values_per_days(day) = mean(storing_values_per_hour);            
        end
        
        fprintf("The hottest hour was the %d of the %d day in the month of %s with a value of %.2f Celcius Degrees \n", hottest_hour, hottest_day, month_print, max_temperature )
        
        return
    end
    function second(data, month)
        array_months = ["January","February","March", "April","May","June","July","Augost","September","Octuber","November","December"];
        month_print = array_months(month);
        % 2. The sunniest hour \n
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        limit_day = days_in_month(month);
        hours_in_day = 24;
        % minutes_per_hour = 60;
        values_solar_radiation = data(:, 10);
        storing_values_per_days = zeros(1, limit_day);
        sunniest_hour = 0;
        sunniest_day = 0;
        max_sunshine = 0;

        for day=1:limit_day % limit day values for a day creation
            storing_values_per_hour = zeros(1, hours_in_day);
            for hour=1:hours_in_day % 24 values for a day creation
                % Skips all the rows for previous days. -> (day - 1) * minutes in a day | 
                % Skips all the rows for hours within the current day.%( hour − 1 ) × 60 (hour−1)×60:
                % 59 because minutes_per_hour is 60, but we start counting from 1
                start_index = (day - 1) * 1440 + (hour - 1) * 60 + 1;
                final_index = start_index + 59;  

                

                % Get the values for each hour from the indexing
                % calculations made.
                values_from_hour = values_solar_radiation(start_index:final_index);
                % Take the average temperature for the hours values gotten
                % from the indexing
                average_hour_sunshine = mean(values_from_hour);

                % Compare the values and evaluate for every interval of 60
                % minutes, and if that was bigger that the last one set it
                % to the new one, then as a consecuence also the day
                if average_hour_sunshine > max_sunshine
                    max_sunshine = average_hour_sunshine;
                    sunniest_hour = hour;
                    sunniest_day = day;
                    
                end
                
                % Store values per hour, once taken the average from it.
                storing_values_per_hour(hour) = average_hour_sunshine;
                % fprintf("Value for the %d day for the hour %d is %.2f", day, hour, average_hour_temperature)
            end
            
            % Calculate and store daily average
            storing_values_per_days(day) = mean(storing_values_per_hour);            
        end
        
        fprintf("The highest solar radiation (sunshine) hour was the %d of the %d day in the month of %s with a value of %.2f (w/mts^2) \n", sunniest_hour, sunniest_day, month_print, max_sunshine )
        
        return
    end
    function third(data, month)
        array_months = ["January","February","March", "April","May","June","July","Augost","September","Octuber","November","December"];
        month_print = array_months(month);
        % 3. the most humed hour humidity(6)
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        limit_day = days_in_month(month);
        hours_in_day = 24;
        % minutes_per_hour = 60;
        values_humidity = data(:, 6);
        storing_values_per_days = zeros(1, limit_day);
        most_humid_hour = 0;
        most_humid_day = 0;
        max_humidity = 0;

        for day=1:limit_day % limit day values for a day creation
            storing_values_per_hour = zeros(1, hours_in_day);
            for hour=1:hours_in_day % 24 values for a day creation
                % Skips all the rows for previous days. -> (day - 1) * minutes in a day | 
                % Skips all the rows for hours within the current day.%( hour − 1 ) × 60 (hour−1)×60:
                % 59 because minutes_per_hour is 60, but we start counting from 1
                start_index = (day - 1) * 1440 + (hour - 1) * 60 + 1;
                final_index = start_index + 59;  

                

                % Get the values for each hour from the indexing
                % calculations made.
                values_from_hour = values_humidity(start_index:final_index);
                % Take the average temperature for the hours values gotten
                % from the indexing
                average_hour_humidity = mean(values_from_hour);

                % Compare the values and evaluate for every interval of 60
                % minutes, and if that was bigger that the last one set it
                % to the new one, then as a consecuence also the day
                if average_hour_humidity > max_humidity
                    max_humidity = average_hour_humidity;
                    most_humid_hour = hour;
                    most_humid_day = day;
                    
                end
                
                % Store values per hour, once taken the average from it.
                storing_values_per_hour(hour) = average_hour_humidity;
                % fprintf("Value for the %d day for the hour %d is %.2f", day, hour, average_hour_temperature)
            end
            
            % Calculate and store daily average
            storing_values_per_days(day) = mean(storing_values_per_hour);            
        end
        
        fprintf("The most humed hour was the %d of the %d day in the month of %s with a value of %.2f (%) percentage. \n", most_humid_hour, most_humid_day, month_print, max_humidity )
        
        return
    end
    function forth(data, month)
        array_months = ["January","February","March", "April","May","June","July","Augost","September","Octuber","November","December"];
        month_print = array_months(month);
        % 1. The highest hour wind speed 
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        limit_day = days_in_month(month);
        hours_in_day = 24;
        % minutes_per_hour = 60;
        values_wind = data(:, 5);
        storing_values_per_days = zeros(1, limit_day);
        windst_hour = 0;
        windst_day = 0;
        max_wind_speed = 0;

        for day=1:limit_day % limit day values for a day creation
            storing_values_per_hour = zeros(1, hours_in_day);
            for hour=1:hours_in_day % 24 values for a day creation
                % Skips all the rows for previous days. -> (day - 1) * minutes in a day | 
                % Skips all the rows for hours within the current day.%( hour − 1 ) × 60 (hour−1)×60:
                % 59 because minutes_per_hour is 60, but we start counting from 1
                start_index = (day - 1) * 1440 + (hour - 1) * 60 + 1;
                final_index = start_index + 59;  

                

                % Get the values for each hour from the indexing
                % calculations made.
                values_from_hour = values_wind(start_index:final_index);
                % Take the average temperature for the hours values gotten
                % from the indexing
                average_hour_wind_speed = mean(values_from_hour);

                % Compare the values and evaluate for every interval of 60
                % minutes, and if that was bigger that the last one set it
                % to the new one, then as a consecuence also the day
                if average_hour_wind_speed > max_wind_speed
                    max_wind_speed = average_hour_wind_speed;
                    windst_hour = hour;
                    windst_day = day;
                    
                end
                
                % Store values per hour, once taken the average from it.
                storing_values_per_hour(hour) = average_hour_wind_speed;
                % fprintf("Value for the %d day for the hour %d is %.2f", day, hour, average_hour_temperature)
            end
            
            % Calculate and store daily average
            storing_values_per_days(day) = mean(storing_values_per_hour);            
        end
        
        fprintf("The highest speed of wind hour was the %d of the %d day in the month of %s with a value of %.2f (Meters/seconds). \n", windst_hour, windst_day, month_print, max_wind_speed )
        
        return
    end 
    
end



function [labelx, labely, typegraph] = typegraphs(array, user_value_type_month)
    for i=1:length(array)
        % Typegraph 1 is just lines, 2 just bars , 3 bars with lines for speed of wind and pressure, 4 points
        if user_value_type_month == array(i)
            switch i
                case 1
                    % Temperature
                    labelx = "Range of days";
                    labely = "Values (°C)";
                    typegraph = 1;
                case 2
                    % Humidity
                    labelx = "Range of days";
                    labely = "Percentage (%)";
                    typegraph = 2;
                case 3
                    % Wind speed
                    labelx = "Range of days";
                    labely = "Wind Speed mts by sec";
                    typegraph = 2;
                case 4
                    % Wind direction
                    labelx = "Range of days";
                    labely = "Direction of the wind (degrees)";
                    typegraph = 4;
                case 5
                    % Pressure
                    labelx = "Range of days";
                    labely = "Pressure in (hPa)";
                    typegraph = 1;
                case 6
                    % Solar radiation
                    labelx = "Range of days";
                    labely = "Solar radiation";
                    typegraph = 2;
                
            end
        end
    end
end

% Monthly Statistics DONE
% 
% 2. The hottest day in the month (according to the 10 hottest hours.)

% Daily Statistics DONE
%

% GRAFY DONE
% 1. Continuous:
% 1.1 Temperature - indicate max/min per day, 
% average for a given period
% 1.2 Wind speed - e.g. every 15min if the value 
% is 2x more than the average of the time window.. 
% show with a bar graph
% 1.3 Pressure
% 2. Point:
% 2.1 Wind direction - e.g. every 15min
% 3. Bar:
% 3.1 Humidity - e.g. every hour
% 3.2 Wind speed
