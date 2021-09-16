%%
clc
clear all
close all
%% 
baseFileName = uigetfile('.csv');
Positions = readmatrix(baseFileName);

%% Extract positions and take out low probability paw positions
filename = baseFileName(13:40);
RealPositions = Positions;

%%
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

% if nanstd(RealPositions(:,12)) > 3
%     disp('Warning: check tracking for top of rotarod');
% end
% 
% if nanstd(RealPositions(:,15)) > 3
%     disp('Warning: check tracking for bottom of rotarod');
% end


%% Replace impossible x value paw positions
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

%% Convert to cm using rotarod height

Rotarodbottomaverage = nanmean(RealPositions(:,15));
Rotarodtopaverage = nanmean(RealPositions(:,12));
Rotarodpixels = Rotarodtopaverage - Rotarodbottomaverage;
Pixelconversion = 3/Rotarodpixels;

Rightpaw_cm = RealPositions(:,3)*Pixelconversion;
Leftpaw_cm = RealPositions(:,6)*Pixelconversion;
Tailbase_cm = RealPositions(:,9)*Pixelconversion;
Rotarodbottom_cm = Rotarodbottomaverage*Pixelconversion;
Rotarodtop_cm = Rotarodtopaverage*Pixelconversion;

%% Calculate positions of paws relative to rotarod
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
%%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Left foot graphs\',filename,'.jpg']);

figure;plot(time, RPpositions, time, Rotarodbottomline_0, 'k', time, Rotarodtopline, 'k', 'LineWidth',1);
ylabel('Y coordinates relative to bottom of rotarod - Right foot');
ylim([-8 5])
xlabel('Time');
title(filename,'Interpreter','none')
%%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Right foot graphs\',filename,'.jpg']);

figure;plot(time, RPpositions, time, LPpositions, 'r', time, Rotarodbottomline_0, 'k', time, Rotarodtopline, 'k', 'LineWidth',1);
ylabel('Y coordinates relative to bottom of rotarod - Both feet');
ylim([-4 5])
xlabel('Time');
legend('right foot','left foot');
%title(filename,'Interpreter','none')
%%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Both foot graphs\',filename,'.jpg']);

%% Calculate slips using PeakFinder

RPpositions_neg = -RPpositions;
LPpositions_neg = -LPpositions;
Rotarodtopline_neg = -Rotarodtopline;

figure; findpeaks(RPpositions_neg, 'MinPeakHeight', 0, 'annotate','extents');
RPslip_number = numel(findpeaks(RPpositions_neg, 'MinPeakHeight', 0, 'annotate','extents'));
[pks,locs] = findpeaks(RPpositions_neg, 'MinPeakHeight', 0,'annotate','extents');
RPsliptimes=[locs/20];
hold on
ylabel('Y coordinate relative to rotarod','FontSize',14)
title(filename,'Interpreter','none')
daspect([1 0.005 1])
%%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Right foot peaks\',filename,'.jpg']);
hold off 

figure; findpeaks(LPpositions_neg, 'MinPeakHeight', 0, 'annotate','extents');
LPslip_number = numel(findpeaks(LPpositions_neg, 'MinPeakHeight', 0, 'annotate','extents'));
[pks,locs] = findpeaks(LPpositions_neg, 'MinPeakHeight', 0,'annotate','extents');
LPsliptimes=[locs/20];
hold on
ylabel('Y coordinate relative to rotarod','FontSize',14)
title(filename,'Interpreter','none')
%daspect([1 0.005 1])
%%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Left foot peaks\',filename,'.jpg']);
hold off 

RPslipsovertime = zeros(falltime,1)
for i=1:length(RPsliptimes)
    RPslipsovertime(round(RPsliptimes(i,1)),1) = 1
end
RPslip_number = sum(RPslipsovertime);

LPslipsovertime = zeros(falltime,1)
for i=1:length(LPsliptimes)
    LPslipsovertime(round(LPsliptimes(i,1)),1) = 1
end
LPslip_number = sum(LPslipsovertime);


Time_converted = [1:1:falltime];
figure;
hold on
bar(RPslipsovertime,'barWidth',0.3)
bar(LPslipsovertime,'barWidth',0.3)
%daspect([1 0.05 1])
hold off;
%%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Foot slips graphed over time\',filename,'.jpg']);

slipsovertime = [LPslipsovertime RPslipsovertime];
slipsovertime(:,3) = LPslipsovertime + RPslipsovertime;
%%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Slips over time\',filename],'slipsovertime','-ascii');

%% Make graphs


labels = categorical({'both', 'left paw', 'right paw'});
bothslip_number = RPslip_number + LPslip_number;
slips = [bothslip_number, LPslip_number, RPslip_number];
figure; bar(labels, slips);

%%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Total foot slip graphs\',filename,'.jpg']);

slipspermin = (slips/falltime)*60;

%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Total slips\',filename],'slips','-ascii');
%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Total slips per min\',filename],'slipspermin','-ascii');

%% Calculate foot height average in 5s intervals
Numberofintervals = floor(falltime/5);
Intervaltime = [ ];
Intervaltime(1,1) = 0;
for i=1:Numberofintervals;
    Intervaltime(i+1,1) = i*5;
end
Intervalframes = Intervaltime*20;

LPheight_intervals = zeros(Numberofintervals,1);
for i = 2:Numberofintervals+1;
    Curr_interval_start = Intervalframes(i-1,1)+1;
    Curr_interval_end = Intervalframes(i);
    LPheight_intervals(i-1,1) = nanmean(LPpositions(Curr_interval_start:Curr_interval_end));
end
figure;plot(Intervaltime(2:end), LPheight_intervals,'Marker','o','MarkerFaceColor','k');
title('Average left foot height (pixels) relative to rotarod');
xlabel('Time (s)');
%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Left foot heights intervals graphs\',filename,'.jpg']);

LPheight_average = nanmean(LPpositions);
LPheight_SD = nanstd(LPpositions);

%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Left foot heights intervals\',filename],'LPheight_intervals','-ascii');
%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Left foot heights average\',filename],'LPheight_average','-ascii');
%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Left foot heights SD\',filename],'LPheight_SD','-ascii');


RPheight_intervals = zeros(Numberofintervals,1);
for i = 2:Numberofintervals+1;
    Curr_interval_start = Intervalframes(i-1,1)+1;
    Curr_interval_end = Intervalframes(i);
    RPheight_intervals(i-1,1) = nanmean(RPpositions(Curr_interval_start:Curr_interval_end));
end
figure;plot(Intervaltime(2:end), RPheight_intervals,'Marker','o','MarkerFaceColor','k');
title('Average left foot height (pixels) relative to rotarod');
xlabel('Time (s)');
%saveas(gcf,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Right foot heights intervals graphs\',filename,'.jpg']);

RPheight_average = nanmean(RPpositions);
RPheight_SD = nanstd(RPpositions);

%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Right foot heights intervals\',filename],'RPheight_intervals','-ascii');
%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Right foot heights average\',filename],'RPheight_average','-ascii');
%save(['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Right foot heights SD\',filename],'RPheight_SD','-ascii');

%% Calculate cumulative foot slips in 10s and 30s intervals
for i = 1:length(slipsovertime);
    cumulativefootslips(i,1) = sum(slipsovertime(1:i,1));
    cumulativefootslips(i,2) = sum(slipsovertime(1:i,2));
    cumulativefootslips(i,3) = sum(slipsovertime(1:i,3));
end
%writematrix(cumulativefootslips,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Cumulative Foot Slips\',baseFileName,'.csv']);

tenintervals = length(slipsovertime)/10;

for j = 1:tenintervals
cumulativefootslipsten(j,1) = sum(slipsovertime(1:10*j,1));
cumulativefootslipsten(j,2) = sum(slipsovertime(1:10*j,2));
end
%writematrix(cumulativefootslipsten,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Cumulative Foot Slips 10s\',baseFileName,'.csv']);

thirtyintervals = length(slipsovertime)/30;

for t = 1:thirtyintervals
cumulativefootslipsthirty(t,1) = sum(slipsovertime(1:30*t,1));
cumulativefootslipsthirty(t,2) = sum(slipsovertime(1:30*t,2));
end
%writematrix(cumulativefootslipsthirty,['C:\Users\ellen\OneDrive\Documents\PhD\Data\Rotarod Videos New DLC data\Cumulative Foot Slips 30s\',baseFileName,'.csv']);

%%
data = [RPheight_average RPheight_SD LPheight_average LPheight_SD];
openvar('data');