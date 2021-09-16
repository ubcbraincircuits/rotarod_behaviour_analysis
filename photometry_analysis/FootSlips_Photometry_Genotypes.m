Fs = 1.017252624511719e+03;
time = ((0:length(YAC_leftslips)-1)/Fs)-5;

%%
figure(1);plot_areaerrorbar(YAC_leftslips(:,1:10173));
xlim([-3 3]);
hold on
plot(time(1:10173),YAC_leftslips(:,1:10173),'LineWidth',2);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
xlim([-1 1]);
title('2-3 month YAC128 Left Slips');
xlabel('Time(s)');
ylabel('Z Score');
hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\','All YAC Left Slips','.jpg']);

figure(1);plot_areaerrorbar(YAC_leftslips(:,1:10173));
xlim([-1 1]);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
xlim([-1 1]);
title('2-3 month WT Large Left Slips');
xlabel('Time(s)');
ylabel('Z Score');

%% Normalize to baseline -5 to -1s

WT_YAC_leftslips_BL = WT_YAC_leftslips(:,round(2*Fs):round(4*Fs));
WT_YAC_leftslips_BL_means = mean(WT_YAC_leftslips_BL,2);
WT_YAC_leftslips_norm = (WT_YAC_leftslips - WT_YAC_leftslips_BL_means)
WT_YAC_leftslips_norm = WT_YAC_leftslips_norm./WT_YAC_leftslips_BL_means;
%%
figure(2);plot_areaerrorbar(rightslips_WT(:,1:10173));
hold on
plot(time(1:10173),rightslips_WT(:,1:10173),'LineWidth',2);
vline(0, 'k');
vline(-0.05, 'k:');
vline(0.05, 'k:');
title('2-3 month WT');
xlabel('Time(s)');
ylabel('Z Score');
hold off
saveas(gcf,['Z:\Raymond Lab\Ellen\Fiber Photometry\2-3 month GCAMP YAC128-FVB - Open Field and Rotarod\Rotarod - 2-3 month GCAMP cohort\Foot Slips Photometry Analysis\Combined Analysis\','All WT Right Slips','.jpg']);
