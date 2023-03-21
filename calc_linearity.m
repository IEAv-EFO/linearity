% Matlab script to separate the flat region where the scale factor is obtained by a 
% mean value.
%
% The PELT algorithm is the candidate to be implemented.

speed_first = 1;
speed_end = 40;
speed_step = 0.5;

number_of_changes = speed_first:speed_step:speed_end;
number_of_changes = length(number_of_changes)*3; % positive, negative, and transition step.

% Separating the changing points
y = output_phase_atan(11885:767637);
x = 1:length(y);

figure
    plot(x, y)

% findchangepts(y, MaxNumChanges=number_of_changes, Statistic="mean")
% findchangepts(y, Statistic="mean")


%% Manual check
% 40deg/s
p1 = 752507;
p2 = 754200;
mean_40 = mean(y(p1:p2)); 

% -40deg/s
p3 = 749800;
p4 = 751520;
mean_neg40 = mean(y(p3:p4));

mean_zero = mean(y(754757:755753));

omega_40 = mean_40 - mean_zero;
omega_neg40 = mean_neg40 - mean_zero;

sf = omega_40/40;


