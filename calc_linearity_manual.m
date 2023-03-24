data = readmatrix("linearity_1_40_05.txt");
t = data(:,1);
y1 = data(:,2);
y2 = data(:,3);

% data tips indicating where the angular velocities are stable
datatips = readmatrix("indexes_linearity_1_40_05.txt");

% these are the angular velocities applied
speed = 1:0.5:40;

% separating the indexes of the data tips into indexes for negative 
% and positive angular velocities
indexes = zeros(length(datatips)/2,2);
for i = 1:2:length(datatips)
    % neg [1, 2, 5, 6, 9, 10...] 
    % pos [3, 4, 7, 8, 11, 12...]

    indexes(i,:) = [i, i+1];    
end
indexes = indexes(1:2:end, :);

% calculating the mean value for each flat step of angular velocity
mean_vel_atan = zeros(size(indexes,1),1);
mean_vel_hg = zeros(size(indexes,1),1);
for i = 1:size(indexes,1)
    mean_vel_atan(i) = mean(y1(datatips(indexes(i,1)):datatips(indexes(i,2))));
    mean_vel_hg(i) = mean(y2(datatips(indexes(i,1)):datatips(indexes(i,2))));
end

neg_mean_vel_atan = mean_vel_atan(1:2:end);
pos_mean_vel_atan = mean_vel_atan(2:2:end);
mean_vel_atan = [flip(neg_mean_vel_atan); pos_mean_vel_atan];

neg_mean_vel_hg = mean_vel_hg(1:2:end);
pos_mean_vel_hg = mean_vel_hg(2:2:end);
mean_vel_hg = [flip(neg_mean_vel_hg); pos_mean_vel_hg];

speed_full = [flip(-speed), speed];

figure
hold on
    plot(speed_full, mean_vel_atan, '.-')
    plot(speed_full, mean_vel_hg, 'o-', 'markersize', 3)

        xlabel("Angular velocity [deg/s]")
        ylabel("Sagnac phase [rad]")
        legend('atan', 'hg')


% Fitting a line to each method
% phase = p1 * angular_speed + p2 
[fit_atan, fit_stat_atan] = fit(speed_full', mean_vel_atan, 'poly1');
[fit_hg, fit_stat_hg] = fit(speed_full', mean_vel_hg, 'poly1');

% scale factor in rad/(deg/s)
scalefactor_atan = fit_atan.p1;
scalefactor_hg =  fit_hg.p1;

L = 573;
D = 15e-2;
lambda = 1550e-9;
c = 3e8;
sagnac_phase = 2*pi*L*D/(lambda*c);
