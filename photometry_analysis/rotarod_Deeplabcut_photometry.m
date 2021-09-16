%%
clc
clear all
close all
%% 
baseFileName = uigetfile('.csv');
Positions = readmatrix(baseFileName);

% Extract positions and take out low probability paw positions
filename = baseFileName(13:40);
RealPositions = Positions;

%
for i=1:length(RealPositions)
    if RealPositions(i,4) < 0.99;
        RealPositions(i,2) = NaN;
        RealPositions(i,3) = NaN;
    end
end

for i=1:length(RealPositions);
    if RealPositions(i,7) < 0.99;
        RealPositions(i,5) = NaN;
        RealPositions(i,6) = NaN;
    end
end

for i=1:length(RealPositions);
    if RealPositions(i,10) < 0.99;
        RealPositions(i,8) = NaN;
        RealPositions(i,9) = NaN;
    end
end

for i=1:length(RealPositions);
    if RealPositions(i,13) < 0.99;
        RealPositions(i,11) = NaN;
        RealPositions(i,12) = NaN;
    end
end

for i=1:length(RealPositions);
    if RealPositions(i,16) < 0.99;
        RealPositions(i,14) = NaN;
        RealPositions(i,15) = NaN;
    end
end


RealPositions(:,2) = repnan(RealPositions(:,2),'linear');
RealPositions(:,3) = repnan(RealPositions(:,3),'linear');
RealPositions(:,5) = repnan(RealPositions(:,5),'linear');
RealPositions(:,6) = repnan(RealPositions(:,6),'linear');
RealPositions(:,8) = repnan(RealPositions(:,8),'linear');
RealPositions(:,9) = repnan(RealPositions(:,9),'linear');
RealPositions(:,11) = repnan(RealPositions(:,11),'linear');
RealPositions(:,12) = repnan(RealPositions(:,12),'linear');
RealPositions(:,14) = repnan(RealPositions(:,14),'linear');
RealPositions(:,15) = repnan(RealPositions(:,15),'linear');

% Replace impossible x value paw positions
%If the x value of the right foot is lower than the left foot, replace x
%and y value with NaN
%If the x value of the left foot is greater than the right foot, replace x
%and y value with NaN
%fill NaN with linear method

for i=1:length(RealPositions(:,2))
    if RealPositions(i,2) < RealPositions(i,5);
        RealPositions(i,2) == NaN;
        RealPositions(i,3) == NaN;
    end
    if RealPositions(i,5) > RealPositions(i,2);
        RealPositions(i,5) == NaN;
        RealPositions(i,6) == NaN;
    end
end

RealPositions(:,2) = repnan(RealPositions(:,2),'linear');
RealPositions(:,3) = repnan(RealPositions(:,3),'linear');
RealPositions(:,5) = repnan(RealPositions(:,5),'linear');
RealPositions(:,6) = repnan(RealPositions(:,6),'linear');

RealTime(:,1) = rmmissing(RealPositions(:,1));
RealPositions = RealPositions(1:length(RealTime),:);

% Convert to cm using rotarod height

Rotarodbottomaverage = nanmean(RealPositions(:,15));
Rotarodtopaverage = nanmean(RealPositions(:,12));
Rotarodpixels = Rotarodtopaverage - Rotarodbottomaverage;
Pixelconversion = 3/Rotarodpixels;

Rightpaw_cm = RealPositions(:,3)*Pixelconversion;
Leftpaw_cm = RealPositions(:,6)*Pixelconversion;
Tailbase_cm = RealPositions(:,9)*Pixelconversion;
Rotarodbottom_cm = Rotarodbottomaverage*Pixelconversion;
Rotarodtop_cm = Rotarodtopaverage*Pixelconversion;

% Calculate positions of paws relative to rotarod
time = RealPositions(:,1)/20;
falltime = round(time(end));
%Rotarodpositions = RealPositions(:,12) - Rotarodaverage;
RPpositions = Rightpaw_cm - Rotarodbottom_cm;
% RPpositions = -RPpositions;
LPpositions = Leftpaw_cm - Rotarodbottom_cm;
% LPpositions = -LPpositions;
Tailpositions = Tailbase_cm - Rotarodbottom_cm;
Relative_positions = [RPpositions LPpositions];

Rotarodbottomline = zeros(1,length(time));
Rotarodbottomline(:,:) = Rotarodbottom_cm;
Rotarodbottomline_0 = Rotarodbottomline - Rotarodbottomline;
Rotarodtopline = zeros(1,length(time));
Rotarodtopline(:,:) = Rotarodtop_cm;
Rotarodtopline = Rotarodtopline - Rotarodbottomline;

figure; plot(time, LPpositions, 'r', time, Rotarodbottomline_0, 'k', time, Rotarodtopline, 'k', 'LineWidth',1);
ylabel('Y coordinates relative to bottom of rotarod - Left foot');
ylim([-8 5])
xlabel('Time');
title(filename,'Interpreter','none')
%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Left foot graphs\',filename,'.jpg']);

figure;plot(time, RPpositions, time, Rotarodbottomline_0, 'k', time, Rotarodtopline, 'k', 'LineWidth',1);
ylabel('Y coordinates relative to bottom of rotarod - Right foot');
ylim([-8 5])
xlabel('Time');
title(filename,'Interpreter','none')
%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Right foot graphs\',filename,'.jpg']);

figure;plot(time, RPpositions, time, LPpositions, 'r', time, Rotarodbottomline_0, 'k', time, Rotarodtopline, 'k', 'LineWidth',1);
ylabel('Y coordinates relative to bottom of rotarod - Both feet');
ylim([-4 5])
xlabel('Time');
legend('right foot','left foot');
%title(filename,'Interpreter','none')
%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Both foot graphs\',filename,'.jpg']);

%% Calculate slips using PeakFinder

RPpositions_neg = -RPpositions;
LPpositions_neg = -LPpositions;
Rotarodtopline_neg = -Rotarodtopline;

figure; findpeaks(RPpositions_neg, 'MinPeakHeight', 0.5, 'annotate','extents');
RPslip_number = numel(findpeaks(RPpositions_neg, 'MinPeakHeight', 0.5, 'annotate','extents'));
[pks,locs,w,p] = findpeaks(RPpositions_neg, 'MinPeakHeight', 0.5,'annotate','extents');
RPsliptimes=[locs/20];
RPslipamps = pks;
hold on
ylabel('Y coordinate relative to rotarod','FontSize',14)
title(filename,'Interpreter','none')
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Right Foot Peaks\',filename,'.jpg']);
hold off 

figure; findpeaks(LPpositions_neg, 'MinPeakHeight', 0.5, 'annotate','extents');
LPslip_number = numel(findpeaks(LPpositions_neg, 'MinPeakHeight', 0.5, 'annotate','extents'));
[pks,locs,w,p] = findpeaks(LPpositions_neg, 'MinPeakHeight', 0.5,'annotate','extents');
LPsliptimes=[locs/20];
LPslipamps = pks;
hold on
ylabel('Y coordinate relative to rotarod','FontSize',14)
title(filename,'Interpreter','none')
%daspect([1 0.005 1])
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Left Foot Peaks\',filename,'.jpg']);
hold off 

LPslip_info = [LPsliptimes LPslipamps];
for i=1:length(LPsliptimes)-1;
    if LPsliptimes(i+1,1) < (LPsliptimes(i,1) + 2.5)
        LPslip_info(i+1,1) = NaN;
    end
end
RPslip_info = [RPsliptimes RPslipamps];
for i=1:length(RPsliptimes)-1;
    if RPsliptimes(i+1,1) < (RPsliptimes(i,1) + 2.5)
        RPslip_info(i+1,1) = NaN;
    end
end

openvar('LPsliptimes');
openvar('RPsliptimes');
openvar('LPslip_info');
openvar('RPslip_info');
%% Save slip amplitudes and times

save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Right Foot Peak Amplitudes\', filename],'RPslipamps', '-ascii');
save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Left Foot Peak Amplitudes\', filename],'LPslipamps', '-ascii');
save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Right Foot Peak Times\', filename],'RPsliptimes', '-ascii');
save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Left Foot Peak Times\', filename],'LPsliptimes', '-ascii');

%% Calculate and save slips using PeakFinder for alternative analysis

RPslip_number_alt = numel(findpeaks(RPpositions_neg, 'MinPeakHeight', 0, 'annotate','extents'));
[pks2,locs2,w2,p2] = findpeaks(RPpositions_neg, 'MinPeakHeight', 0,'annotate','extents');
RPsliptimes_alt=[locs2/20];
RPslipamps_alt = pks2;

LPslip_number_alt = numel(findpeaks(LPpositions_neg, 'MinPeakHeight', 0, 'annotate','extents'));
[pks2,locs2,w2,p2] = findpeaks(LPpositions_neg, 'MinPeakHeight', 0,'annotate','extents');
LPsliptimes_alt=[locs2/20];
LPslipamps_alt = pks2;

save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Alternative Analysis (No min peak)\Right Foot Peak Amplitudes\', filename],'RPslipamps_alt', '-ascii');
save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Alternative Analysis (No min peak)\Left Foot Peak Amplitudes\', filename],'LPslipamps_alt', '-ascii');
save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Alternative Analysis (No min peak)\Right Foot Peak Times\', filename],'RPsliptimes_alt', '-ascii');
save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Alternative Analysis (No min peak)\Left Foot Peak Times\', filename],'LPsliptimes_alt', '-ascii');


%% Import data from TDT files
% Update with current folder path

photometrydata = TDTbin2mat(uigetdir);

%%
% %% Create time vector from data
% % Fs = sampling rate
% % tssub = take out first ~10 seconds of data
% 
ts = (1:length(photometrydata.streams.x65B.data))/photometrydata.streams.x65B.fs;
Fs=photometrydata.streams.x65B.fs;


%%
%%Extract signal and control data and create plot
% Apply lowpass filter 

tssub = ts(round(10*Fs):end);
sig=photometrydata.streams.x65B.data(round(10*Fs):end);
ctr=photometrydata.streams.x05V.data(round(10*Fs):end);

figure; plot(tssub,sig)
hold on
plot(tssub,ctr)
xlabel('Time(s)','FontSize',14)
ylabel('mV at detector','FontSize',14)
hold off
saveas(gcf, 'Raw data figure.emf')
% 
% %% Normalize signal to control channel, plot and save figure
% % Add notes to plot
% 
[normDat] = deltaFF (sig,ctr);
figure;plot(tssub, normDat);
hold on
xlabel('Time(s)','FontSize',14);
ylabel('deltaF/F','FontSize',14);
saveas(gcf, 'Figure dFF and Notes.emf');
hold off
% 
% Calculate z score and create plot
%
load Timestamps.mat 
Pickup = round(Timestamps(1,1)*Fs);
Start = round(Timestamps(1,2)*Fs);
Stop = round(Timestamps(1,3)*Fs);
Down = round(Timestamps(1,4)*Fs);

%load normDat.mat 
[zscore] = zScore(normDat);
figure;plot(tssub, zscore)
hold on
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
daspect([1 0.05 1])
vline([Timestamps(1,1) Timestamps(1,2) Timestamps(1,3) Timestamps(1,4)],{'k','g','g','k'});

%saveas(gcf, 'Figure Z Score and Notes.emf')

hold off

% %% Downsample data

%% Convert time in seconds to acquisition rate
% Line up timing to when the mouse starts on the rotarod
% Define timing for different parts of trial
load Timestamps.mat 
Pickup = round((Timestamps(1,1)-10)*Fs);
Start = round((Timestamps(1,2)-10)*Fs);
Stop = round((Timestamps(1,3)-10)*Fs);
Down = round((Timestamps(1,4)-10)*Fs);
%End = round(Notesoff(4,1));

%% Isolate rotarod data

rotarod_zscore = zscore(Start:Stop);
rotarod_ts = tssub(Start:Stop);
rotarod_ts = rotarod_ts - rotarod_ts(1,1);

rotarod_sig = sig(Start:Stop);

rotarod_zscore=double(rotarod_zscore);
rotarod_zscore_down=downsample(rotarod_zscore,50)';
figure;
plot(rotarod_ts, rotarod_zscore);
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Rotarod Z Score Plots\',filename,'.jpg']);

%Check Time and make sure they match
if rotarod_ts(1,end) - time(end,1) > 0.05
    disp('Error: times might not match');
else
    disp('Times match');
end

%% Interpolate speed data and position data with neural activity and plot

% interp_slips = interp1(rotarod_ts_down, rotarod_zscore_down, Time_converted, 'pchip');
% %overlap = [ts_down(10:12000), interpspeed(10:12000), zscore_down(10:12000)];
% figure; subplot(2,1,1)
% %ts_down = ts_down(10:12000);
% %interpspeed = interpspeed(10:12000);
% %zscore_down = zscore_down(10:12000);
% figure;
% 
% plot(Time_converted, interp_slips);
% figure;
% plot(rotarod_ts, rotarod_zscore);

%% Convert slip times into times on rotarod

% timefactor = length(rotarod_ts_down)/length(slipsovertime);
% slips_converted = timefactor*RPsliptimes; 
RPsliptimes = RPslip_info(:,1);
RPsliptimes(any(isnan(RPsliptimes), 2), :) = [];
rightslips_converted = RPsliptimes(:,1) *Fs; 

LPsliptimes = LPslip_info(:,1);
LPsliptimes(any(isnan(LPsliptimes), 2), :) = [];
leftslips_converted = LPsliptimes(:,1) *Fs; 

% 
% rightslip1_start = round(rightslips_converted(1,1) - 5*Fs);
% rightslip1_end = round(rightslips_converted(1,1) + 5*Fs);
% figure;plot(ts(rightslip1_start:rightslip1_end), slip1_zscore);
% vline(RPsliptimes(1,1)-0.025,':');
% vline(RPsliptimes(1,1)+0.025,':');
% vline(RPsliptimes(1,1),'-');
% axis tight
% 
% figure;plot(test_time,slip1,test_time,slip2);
% axis tight
% vline(2501);
% 
% slip2 = rotarod_zscore((slips_converted(2,1) - 2500):(slips_converted(2,1) + 2500));
% figure;plot(rotarod_ts((slips_converted(2,1) - 2500):(slips_converted(2,1) + 2500)), slip2);
% vline(RPsliptimes(2,1)-0.025,'-');
% vline(RPsliptimes(2,1)+0.025,'-');
% vline(RPsliptimes(2,1),'-');
% axis tight
% 
% slip3 = rotarod_zscore((slips_converted(3,1) - 2500):(slips_converted(3,1) + 2500));
% figure;plot(rotarod_ts((slips_converted(3,1) - 2500):(slips_converted(3,1) + 2500)), slip3);
% vline(RPsliptimes(3,1)-0.025,'-');
% vline(RPsliptimes(3,1)+0.025,'-');
% vline(RPsliptimes(3,1),'-');
% axis tight
%% Plot each foot slip occurance (excluding close together ones)

if length(rightslips_converted >0);
for i=1:length(rightslips_converted);
    rightslip_start(1,i) = round(rightslips_converted(i,1) - 5*Fs);
    if rightslip_start(1,i) < 0;
        rightslip_start(1,i) = 1;
    else
    end
    rightslip_stop(1,i) = round(rightslips_converted(i,1) + 5*Fs);
    if rightslip_stop(1,i) > length(rotarod_ts);
        rightslip_stop(1,i) = length(rotarod_ts);
    else
    end
    rightslips{1,i} = rotarod_zscore(rightslip_start(1,i):rightslip_stop(1,i));
    h = figure;plot(rotarod_ts(rightslip_start(1,i):rightslip_stop(1,i)), rightslips{1,i});
    vline(RPsliptimes(i,1)-0.025,':');
    vline(RPsliptimes(i,1)+0.025,':');
    vline(RPsliptimes(i,1),'-');
    axis tight
%save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Right Foot Slips Z Score\', data.info.blockname(1,:)],'rightslips', '-ascii');
    
end
else
end

if length(leftslips_converted) > 0;
for i=1:length(leftslips_converted);
    %slip{8} = zeros(10180, 1);
    leftslip_start(1,i) = round(leftslips_converted(i,1) - 5*Fs);
    if leftslip_start(1,i) < 0;
       leftslip_start(1,i) = 1;
    else
    end
    leftslip_stop(1,i) = round(leftslips_converted(i,1) + 5*Fs);
    if leftslip_stop(1,i) > length(rotarod_ts);
       leftslip_stop(1,i) = length(rotarod_ts);
    else
    end
    leftslips{1,i} = rotarod_zscore(leftslip_start(1,i):leftslip_stop(1,i))
    h = figure;plot(ts(leftslip_start(1,i):leftslip_stop(1,i)), leftslips{1,i});
    vline(LPsliptimes(i,1)-0.025,':');
    vline(LPsliptimes(i,1)+0.025,':');
    vline(LPsliptimes(i,1),'-');
    axis tight
%save(['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Left Foot Slips Z Score\', filename],'leftslips', '-ascii');

end
else
end


%% Plot all foot slips on one graph
ts_sub = ts - 5;
figure; hold on
for i=1:length(rightslips_converted);
    if rightslip_start(1,i) == 1; 
    disp('Foot slip (i) too close to beginning,skipped');
    continue
    end
    plot(ts_sub(1:length(rightslips{i})), rightslips{i});
    axis tight
    vline(0,'k');
    title('Lined up to Right Foot Slips');
    
end
hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Lined Up Right Foot Slip Plots\',filename,'.jpg']);

%figure;plot(test_time,slip{1,1},test_time,slip{2},test_time,slip{3},test_time,slip{4},test_time,slip{5});

figure; hold on
for i=1:length(leftslips_converted);
    if leftslip_start(1,i) == 1; 
    disp('Foot slip (i) too close to beginning,skipped');
    continue
    end
    plot(ts_sub(1:length(leftslips{i})), leftslips{i});
    axis tight
    vline(0,'k');
    title('Lined up to Left Foot Slips');
   
end

hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Lined Up Left Foot Slip Plots\',filename,'.jpg']);


% %% Normalize to before signal 
% figure; hold on
% for i=1:length(slip)
% slipbefore{i} = zeros(18,1);
% slipbefore{i} = slip{i};
% slipbefore{i}(19:end,:) = [];
% slipnormalized{i} = (slip{i}- mean(slipbefore{i}));
% plot(time_lineduptoslip,slipnormalized{i})
% axis tight
% vline(0)
% end
% hold off
% 
% %% Use raw data and calculate dF/F before plotting
% figure; hold on
% for i=11:21;
%     slip{i} = zeros(1, 4001);
%     slip{i} = interp_slips((slips_converted(i,1) - 18):(slips_converted(i,1) + 20));
%     %slip{i} = (slip{i} - mean(slip{i}(1:18,:))) / mean(slip{i}(1:18,:))
%     plot(time_lineduptoslip,slip{i});
%     vline(0)
%     ylim([-1.5 2])
%     title('11-21 slips');
%    % axis tight
% end
% hold off

%% Compare to random points
random_control = 0 + length(rotarod_zscore).*rand(30,1);
random_times = random_control/Fs;

for i=1:30
    random{i} = zeros(10180, 1);
    random_start(1,i) = round(random_control(i,1) - 5*Fs);
    if random_start(1,i) < 0
        continue
    end
    random_stop(1,i) = round(random_control(i,1) + 5*Fs);
    if random_stop(1,i) > length(rotarod_ts);
        continue
    end
    random{1,i} = rotarod_zscore(random_start(1,i):random_stop(1,i));
    %h=figure;plot(ts(random_start(1,i):random_stop(1,i)), random{1,i});
    %vline(random(i,1)-0.025,':');
    %vline(random(i,1)+0.025,':');
    %vline(random(i,1),'-');
    %axis tight
    %saveas(h,sprintf('RANDOM%d.png',i))
end

figure; hold on
for i=1:30;
    plot(ts(1:length(random{i})), random{i});
    axis tight
    vline(5)
    title('Lined up to Random Points');
end
hold off
saveas(gcf,'random.jpg');

save('randomtimes.mat','random');

%%

for i=1:length(rightslips);
    rightslipsvalues(i,1:length(rightslips{1,i})) = rightslips{i};
end
save('rightslips.mat','rightslipsvalues');
openvar('rightslipsvalues');

for i=1:length(leftslips);
    leftslipsvalues(i,1:length(leftslips{1,i})) = leftslips{i};
end
save('leftslips.mat','leftslipsvalues');
openvar('leftslipsvalues');


for i=1:length(random);
    randomvalues(i,1:length(random{1,i})) = random{i};
end

save('randomtimes.mat','randomvalues');
openvar('randomvalues');