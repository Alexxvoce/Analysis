% Week 7 Coding Practical
%%
close all; clear all; clc

% 1 - ON cell

% define time properties
MaxT = 1.5; % length of background - no light
Ti = 0.01; % time interval from bin to bin = 10ms
All_bins = 0:Ti:MaxT;

% trial type 1


% cell firing
CellFiring = zeros(1,length(All_bins));

% use to embed 60% probability of background firing
tmp = randi(100);

% cycle through experiment
for i = 1:length(All_bins)
    if All_bins(i) <=0.5
        x = randi(100); % generating random integer from 1-100
        if x<11 % select time points where cell fires
            firing_yes_no = 1; % if randi returns 10 or less, cell fires
        else
            firing_yes_no = 0; %cell doesnt fire
        end
        CellFiring(i) = firing_yes_no;
    end
    if All_bins(i) > 0.5 && All_bins(i) <= 1
        x = randi(100); % generating random integer from 1-100
        if x<61 % select time points where cell fires
            firing_yes_no = 1; % if randi returns 60 or less, cell fires
        else
            firing_yes_no = 0; % , cell doesnt fire
        end
        CellFiring(i) = firing_yes_no; % assigning cell firing to vector containing rates
    end
    if All_bins(i) > 1
        x = randi(100); % generating random integer from 1-100
        if x<11 % select time points where cell fires
            firing_yes_no = 1; % if randi returns 60 or less, cell fires
        else
            firing_yes_no = 0; % , cell doesnt fire
        end
        CellFiring(i) = firing_yes_no; % assigning cell firing to vector containing rates
    end
end

figure
plot(All_bins,CellFiring,'+r')
xlabel('Time Secs')
ylabel('Firing, 0: No, 1:yes')
title('Background Firing Rate')
ylim([-0.5 1.5])
%%
% define time properties
MaxT = 1.5; % length of background - no light
Ti = 0.01; % time interval from bin to bin = 10ms
All_bins = 0:Ti:MaxT;

% trial type 1


% cell firing
CellFiring = zeros(1,length(All_bins));
% trial 2
for i = 1:length(All_bins)
    if All_bins(i) <=0.5
        x = randi(100); % generating random integer from 1-100
        if x<11 % select time points where cell fires
            firing_yes_no = 1; % if randi returns 10 or less, cell fires
        else
            firing_yes_no = 0; %cell doesnt fire
        end
        CellFiring(i) = firing_yes_no;
    end
%     if All_bins(i) > 0.5 && All_bins(i) <= 1
%             firing_yes_no = 0; % , cell doesnt fire
%         CellFiring(i) = firing_yes_no; % assigning cell firing to vector containing rates
%     end
    if All_bins(i) > 1
        x = randi(100); % generating random integer from 1-100
        if x<11 % select time points where cell fires
            firing_yes_no = 1; % if randi returns 60 or less, cell fires
        else
            firing_yes_no = 0; % , cell doesnt fire
        end
        CellFiring(i) = firing_yes_no; % assigning cell firing to vector containing rates
    end
end
figure
plot(All_bins,CellFiring,'+r')
xlabel('Time Secs')
ylabel('Firing, 0: No, 1:yes')
title('Background Firing Rate')
ylim([-0.5 1.5])
% doesnt look correct ask

%% 
clear all; close all; clc

% 2 - OFF cell 6 trials

% define time properties
MaxT = 1.5; % length of background - no light
Ti = 0.01; % time interval from bin to bin = 10ms
All_bins = 0:Ti:MaxT;



% cell firing
CellFiring = zeros(6,length(All_bins));

% trials
trial_prob = [10 0 80; 10 0 80; 10 0 80; 10 60 10; 10 60 10; 10 60 10];

% first 3 trials
% cycle through experiment
for t = 1:6
    for i = 1:length(All_bins)
        if All_bins(i) <=0.5
            x = randi(100); % generating random integer from 1-100
            if x< trial_prob(t,1) % select time points where cell fires
                firing_yes_no = 1; % if randi returns 10 or less, cell fires
            else
                firing_yes_no = 0; %cell doesnt fire
            end
            CellFiring(t,i) = firing_yes_no;
        end
        if All_bins(i) > 0.5 && All_bins(i) <= 1
            x = randi(100); % generating random integer from 1-100
            if x< trial_prob(t,2)% select time points where cell fires
                firing_yes_no = 1; % if randi returns 60 or less, cell fires
            else
                firing_yes_no = 0; % , cell doesnt fire
            end
            CellFiring(t,i) = firing_yes_no; % assigning cell firing to vector containing rates
        end
        if All_bins(i) > 1
            x = randi(100); % generating random integer from 1-100
            if x< trial_prob(t,3) % select time points where cell fires
                firing_yes_no = 1; % if randi returns 60 or less, cell fires
            else
                firing_yes_no = 0; % , cell doesnt fire
            end
            CellFiring(t,i) = firing_yes_no; % assigning cell firing to vector containing rates
        end
    end
end

figure
imagesc(CellFiring)
colorbar
xlabel('Time Secs')
ylabel('Trials')
title('OFF cell firing')

%% 
clear all; close all; clc

% 3 - activity in V1
Time = [0:0.01:3];
% cell firing 
CellFiring = zeros(1,length(Time));
% draw vectors holding firing rate
stimuli1 = zeros(3);
stimuli2 = zeros(3);

% plot stimuli 
stim1x = [-1 1];
stim1y = [0 0];
figure
subplot(2,1,1)
plot(stim1x, stim1y, 'LineWidth',10)
title('Stimulus 1')
xlim([-1.5,1.5])
ylim([-1.5,1.5])

stim5x = [0 0];
stim5y = [1 -1];
figure
subplot(2,1,1)
plot(stim5x, stim5y, 'LineWidth',10)
title('Stimulus 5')
xlim([-1.5,1.5])
ylim([-1.5,1.5])
% creating matrix
stimulusMatrix = zeros(2,length(Time));

% loop 
for i = 1:length(Time)
    if Time(i) >= 1 && Time(i) <2
        x = randi(100);
        if x<51
            firing_yes_no = 1; % if randi returns 60 or less, cell fires
        else
            firing_yes_no = 0; % , cell doesnt fire
        end
        CellFiring(i) = firing_yes_no;
        stimulusMatrix(2,i) = firing_yes_no;
    end
end

% plot firing rate
figure
imagesc(stimulusMatrix)