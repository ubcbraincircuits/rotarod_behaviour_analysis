%% Left Paw
% All Slips
clear all
%%
Fs = 1.017252624511719e+03;
mouse = input('mouse name:','s');
%%
leftslips = zeros(10,5000);
% Put left slips data in

%%
leftslips = leftslips(any(leftslips,2),:);
leftslips(leftslips == NaN) = 0;
time = ((0:length(leftslips)-1)/Fs)-5;

%%

figure;plot(time(1:10173),YAC_leftslips(:,1:10173));
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Left Foot Slips Individuals per mouse\',mouse,'.jpg']);

figure(1);plot_areaerrorbar(leftslips);
axis tight
xlim([-5 5]);
%ylim([0 1.5]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Left Foot Slips");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Left Foot Slips per mouse\',mouse,'.jpg']);

figure(2);plot_areaerrorbar(leftslips);
axis tight
xlim([-3 3]);
%ylim([0 1.5]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Left Foot Slips");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Left Foot Slips per mouse 3s\',mouse,'.jpg']);

figure(3);plot_areaerrorbar(leftslips);
axis tight
xlim([-1 1]);
%ylim([0 1.5]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
%daspect([1 0.4 1])
title(mouse + " Lined up to Left Foot Slips");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Left Foot Slips per mouse 1s\',mouse,'.jpg']);

meanleftslips = mean(leftslips);
%% Slips only on one side
oneside_left = leftslips;

% remove slips that occur on right side as well

%% 
oneside_left = oneside_left(any(oneside_left,2),:);
%%
figure(1);plot_areaerrorbar(oneside_left);
axis tight
xlim([-5 5]);
%ylim([-1 0.5]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Only Left Foot Slips");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Left Slips per mouse\',mouse,'.jpg']);

figure(2);plot_areaerrorbar(oneside_left);
axis tight
xlim([-3 3]);
%ylim([-1 0.5]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Left Foot Slips - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Left Slips per mouse 3s\',mouse,'.jpg']);

figure(3);plot_areaerrorbar(oneside_left);
axis tight
xlim([-1 1]);
%ylim([-1 0.5]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
%daspect([1 0.5 1])
title(mouse + " Lined up to Left Foot Slips - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Left Slips per mouse 1s\',mouse,'.jpg']);

mean_oneside_left = mean(oneside_left);

%% Plot with same axes 
figure(1);plot_areaerrorbar(oneside_left);
axis tight
xlim([-5 5]);
ylim([-0.5 2]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.5 1])
title(mouse + " Lined up to Only Left Foot Slips");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Left Slips per mouse Same Axes\',mouse,'.jpg']);

figure(2);plot_areaerrorbar(oneside_left);
axis tight
xlim([-3 3]);
ylim([-0.5 2]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.6 1])
title(mouse + " Lined up to Left Foot Slips - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Left Slips per mouse 3s Same Axes\',mouse,'.jpg']);

figure(3);plot_areaerrorbar(oneside_left);
axis tight
xlim([-1 1]);
ylim([-0.5 2]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
%daspect([1 0.5 1])
title(mouse + " Lined up to Left Foot Slips - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Left Slips per mouse 1s Same Axes\',mouse,'.jpg']);


%% Right Paw 
% All Slips
% rightslips_avg = mean(rightslips,1);
% sd_rightslips = std(rightslips,1);
% sem_rightslips = sd_rightslips/sqrt(size(rightslips,1));
rightslips = zeros(10,5000);

%%
rightslips = rightslips(any(rightslips,2),:);

%%
figure(1);plot_areaerrorbar(rightslips);
axis tight
xlim([-5 5]);
%ylim([-0.1 0.35]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Right Foot Slips - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Right Foot Slips per mouse\',mouse,'.jpg']);

figure(2);plot_areaerrorbar(rightslips);
axis tight
xlim([-3 3]);
%ylim([-0.1 0.35]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Right Foot Slips - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Right Foot Slips per mouse 3s\',mouse,'.jpg']);

figure(3);plot_areaerrorbar(rightslips);
axis tight
xlim([-1 1]);
%ylim([-0.1 0.35]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Right Foot Slips - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Right Foot Slips per mouse 1s\',mouse,'.jpg']);

meanrightslips = mean(rightslips);

%% Slips only on one side
oneside_right = rightslips;

%%
oneside_right = oneside_right(any(oneside_right,2),:);

figure(1);plot_areaerrorbar(oneside_right);
axis tight
xlim([-5 5]);
%ylim([-0.15 0.35]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Only Right Foot Slips");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Right Slips per mouse\',mouse,'.jpg']);

figure(2);plot_areaerrorbar(oneside_right);
axis tight
xlim([-3 3]);
%ylim([-0.15 0.35]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Only Right Foot Slips");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Right Slips per mouse 3s\',mouse,'.jpg']);

figure(2);plot_areaerrorbar(oneside_right);
axis tight
xlim([-1 1]);
%ylim([-0.15 0.35]);

vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.4 1])
title(mouse + " Lined up to Only Right Foot Slips");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Only Right Slips per mouse 1s\',mouse,'.jpg']);

mean_oneside_right = mean(oneside_right);

%% Random Times
randomtimes = zeros(10,5000);

%%
randomtimes = randomtimes(any(randomtimes,2),:);

figure(1);plot_areaerrorbar(randomtimes);
axis tight
xlim([-5 5]);
%ylim([-0.15 0.35]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.2 1])
title(mouse + " Lined up to Random Times - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Random Times per mouse\',mouse,'.jpg']);

figure(2);plot_areaerrorbar(randomtimes);
axis tight
xlim([-3 3]);
%ylim([-0.15 0.35]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
daspect([1 0.2 1])
title(mouse + " Lined up to Random Times - Average");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Random Times per mouse 3s\',mouse,'.jpg']);

figure(3);plot_areaerrorbar(randomtimes);
axis tight
xlim([-1 1]);
%ylim([-0.15 0.35]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
%daspect([1 0.5 1])
title(mouse + " Lined up to Random Times");
xlabel('Time(s)','FontSize',14)
ylabel('Z Score','FontSize',14)
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Random Times per mouse 1s\',mouse,'.jpg']);

meanrandom = mean(randomtimes);
%% Save workspace

save(mouse);