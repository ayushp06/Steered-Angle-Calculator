% MATLAB Script to Calculate Steered Angle in Degrees
clc;
clear;

% Load the data
% Assuming the data file 'track_data.csv' has columns: time, yaw_rate, speed, gps_x, gps_y
data = readtable('44.csv');

% Constants
L = 1.58; % Wheelbase in meters

% Extract relevant columns
yaw_rate = data.yaw_rate; % Yaw rate (rad/s)
speed = data.speed;       % Speed (m/s)

% Calculate steered angle (in radians)
steered_angle_rad = atan(yaw_rate .* L ./ speed);

% Convert steered angle to degrees
steered_angle_deg = rad2deg(steered_angle_rad);

% Append the calculated steered angle to the data table
data.steered_angle_deg = steered_angle_deg;

% Smooth the steered angle (optional, using a moving average)
window_size = 5;
data.steered_angle_smoothed_deg = movmean(steered_angle_deg, window_size);

% Save the updated data table to a new file
writetable(data, 'track_data_with_steered_angle.csv');

% Visualization
figure;
scatter(data.gps_x, data.gps_y, 20, data.steered_angle_smoothed_deg, 'filled');
colormap('jet');
colorbar;
title('Steered Angle Along Track');
xlabel('GPS X Position');
ylabel('GPS Y Position');
c = colorbar;
c.Label.String = 'Steered Angle (degrees)';
grid on;

% Display completion message
disp('new data.csv.');
