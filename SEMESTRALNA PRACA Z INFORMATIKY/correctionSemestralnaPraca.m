% Load the data
load('meteodata.mat');

% Assumptions for column indices (modify if needed):
% Column 2: Day of the month
% Column 4: Hour of the day
% Column 5: Temperature (°C)
% Column 6: Humidity (%)
% Column 10: Solar Radiation (W/m²)

% Extract relevant columns
day = meteodata(:, 2);
time = meteodata(:, 4);
temperature = meteodata(:, 5);
humidity = meteodata(:, 6);
solar_radiation = meteodata(:, 10);

% --- Scenario 1: Hottest Hour in the Month ---
[max_temp, max_index] = max(temperature); % Find the max temperature and its index
hottest_day = day(max_index);            % Day of the hottest hour
hottest_hour = time(max_index);          % Hour of the hottest hour
fprintf('The hottest hour is on Day %d, Hour %d with a temperature of %.2f°C.\n',hottest_day, hottest_hour, max_temp);

% --- Scenario 2: Monthly Solar Radiation ---
num_days = max(day); % Number of days in the dataset
daily_avg_radiation = zeros(num_days, 1); % Initialize array for daily averages
for d = 1:num_days
    daily_avg_radiation(d) = mean(solar_radiation(day == d));
end
[sorted_radiation, sorted_days] = sort(daily_avg_radiation, 'descend'); % Sort by average radiation
disp('Days sorted by average solar radiation:');
for i = 1:length(sorted_days)
    fprintf('Day %d: %.2f W/m²\n', sorted_days(i), sorted_radiation(i));
end

% --- Scenario 3: Graph of Daily Humidity ---
selected_day = 1; % Change this to analyze another day
daily_humidity = humidity(day == selected_day); % Filter humidity for the selected day
daily_time = time(day == selected_day);         % Filter time for the selected day

% Calculate statistics
mean_humidity = mean(daily_humidity);
max_humidity = max(daily_humidity);
min_humidity = min(daily_humidity);

% Plot hourly humidity trends
figure;
plot(daily_time, daily_humidity, '-o', 'LineWidth', 1.5);
hold on;
yline(mean_humidity, '--', 'Mean', 'Color', 'green', 'LineWidth', 1.5);
yline(max_humidity, '-', 'Max', 'Color', 'red', 'LineWidth', 1.5);
yline(min_humidity, '-', 'Min', 'Color', 'blue', 'LineWidth', 1.5);
hold off;

title(sprintf('Hourly Humidity Trend for Day %d', selected_day));
xlabel('Hour of the Day');
ylabel('Humidity (%)');
grid on;
legend('Hourly Humidity', 'Mean', 'Max', 'Min', 'Location', 'best');

% Save the graph
saveas(gcf, sprintf('daily_humidity_day_%d.png', selected_day));
