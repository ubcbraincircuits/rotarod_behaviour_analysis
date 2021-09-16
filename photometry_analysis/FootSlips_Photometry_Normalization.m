%%
clear all
close all
%%
Fs = 1.017252624511719e+03;
mouse = input('mouse name:','s');

%%
WTlargeslips_left_BL = WTlargeslips_left(:,round(2*Fs):round(4*Fs));
WTlargeslips_left_BL_means = mean(WTlargeslips_left_BL,2);
WTlargeslips_left_norm = WTlargeslips_left - WTlargeslips_left_BL_means;
%leftslips_norm = leftslips_norm./leftslips_BL_means;
mean_WTlargeslips_left_norm = mean(WTlargeslips_left_norm);

figure(1);plot_areaerrorbar(WTlargeslips_left_norm(:,1:10173));
%daspect([1 0.3 1]);
xlim([-3 3]);
ylim([-0.2 0.3]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
title(mouse);
xlabel('Time(s)');
ylabel('Normalized Z Score');
hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\','WT Normalized Large Left Slips 3s','.jpg']);

figure(1);plot_areaerrorbar(WTlargeslips_left_norm(:,1:10173));
xlim([-1 1]);
%ylim([-0.5 1]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
title(mouse);
xlabel('Time(s)');
ylabel('Normalized Z Score');
hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Normalized Left Slips - Large 1s\','YAC128 Normalized Left Slips','.jpg']);



openvar('mean_leftslips_norm');
%%
hold on
plot(time(1:10173),YAC_leftslips_norm(:,1:10173),'LineWidth',2);
daspect([1 0.3 1]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
xlim([-3 3]);
ylim([-0.3 0.7]);
title('2-3 month YAC128');
xlabel('Time(s)');
ylabel('Normalized Z Score');
hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\','Individual YAC128 left slips norm','.jpg']);

%%
%% randomtimes times
%%
randomtimes_BL = randomtimes(:,round(2*Fs):round(4*Fs));
randomtimes_BL_means = mean(randomtimes_BL,2);
randomtimes_norm = randomtimes - randomtimes_BL_means;
%randomtimes_norm = randomtimes_norm./randomtimes_BL_means;
mean_randomtimes_norm = mean(randomtimes_norm);

figure(1);plot_areaerrorbar(randomtimes_norm(:,1:10173));
xlim([-3 3]);
ylim([-0.5 1]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
title(mouse);
xlabel('Time(s)');
ylabel('Normalized Z Score');
hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Normalized Random Times per mouse\',mouse,'.jpg']);

openvar('mean_randomtimes_norm');
%%
hold on
plot(time(1:10173),WT(:,1:10173),'LineWidth',2);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
xlim([-3 3]);
ylim([-0.3 0.7]);
title('2-3 month WT');
xlabel('Time(s)');
ylabel('Normalized Z Score');
hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\Normalized Left Slips per mouse\','146m3-1 individual slips','.jpg']);

