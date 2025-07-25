clear
clc
close all

gry = [0.7, 0.7, 0.7];
purple = [0.4940 0.1840 0.5560];
purple2 = [75 0 130]./255;
lpurple = [0.9940 0.1840 0.5560];

color_Pa = [0, 0, 0]./255;
color_Pa_shade = gry; %0.7 .* color_Pa;

color_Kp = purple2;
color_Kp_shade = 0.7 .* color_Kp;

% color_Pa = [23, 162, 184]./255;
% color_Pa_shade = 0.7 .* color_Pa;

% color_Kp = [178, 64, 59]./255;
% color_Kp_shade = 0.7 .* color_Kp;

M1 = readmatrix('ProcessedTimeCourse_E23_MD_NoCTX_MovAvg04_.xlsx');
M2 = readmatrix('ProcessedTimeCourse_E23_MD_CTX2p5_MovAvg04_.xlsx');
figFileName = 'Kp_final_HD.pdf';

x1 = M1(:, 1)';
y1 = M1(:, 2:end)';

x2 = M2(:, 1)';
y2 = M2(:, 2:end)';

% Make the plot
clf
fig1 = figure(1);
s1 = shadedErrorBar(x1, y1, {@mean,@std},'lineprops', {'-', 'Color', color_Pa, 'MarkerFaceColor', color_Pa},'patchSaturation',0.33);
% Set face and edge properties
set(s1.edge,'LineWidth', 0.1, 'LineStyle', '-', 'Color', color_Pa_shade)
s1.mainLine.LineWidth = 4;
s1.patch.FaceColor = color_Pa_shade; %[0.5, 0.25, 0.25];

% Overlay data points post-hoc
hold on
plot(s1.mainLine.XData, s1.mainLine.YData, '.', 'Color', color_Pa, 'MarkerFaceColor', color_Pa)

% Overlay second line
hold on
s2 = shadedErrorBar(x2, y2, {@mean,@std},'lineprops', {'-', 'Color', color_Kp, 'MarkerFaceColor', color_Kp});
% Set face and edge properties
set(s2.edge,'LineWidth', 0.1, 'LineStyle', '-', 'Color', color_Kp_shade)
s2.mainLine.LineWidth = 4;
s2.patch.FaceColor = color_Kp_shade;

% Overlay data points post-hoc
hold on
% plot(s2.mainLine.XData, s2.mainLine.YData, '-', 'MarkerFaceColor', color_Kp)
plot(s2.mainLine.XData, s2.mainLine.YData, '.', 'Color', color_Kp, 'MarkerFaceColor', color_Kp)

hold off
xlim([0 27])
ylim([0 1])
% set(gca, 'Linewidth', 1.5, 'FontSize', 36, 'XTick', [0:6:24], 'YTick', [0:0.25:1], 'TickDir', 'out')
% % Custom tick labels
% xticklabels({'0', '', '12', '', '24'});   % X-axis custom tick labels
% yticklabels({'0', '', '0.5', '', '1'}); % Y-axis custom tick labels
% xlabel('time (h)', 'FontSize', 44)
% ylabel('OD_{600}', 'FontSize', 44)

set(gca, 'Linewidth', 1.5, 'FontSize', 27, 'XTick', [0:6:24], 'YTick', [0:0.25:1], 'TickDir', 'out')
% Custom tick labels
xticklabels({'0', '6', '12', '18', '24'});   % X-axis custom tick labels
yticklabels({'0', '0.25', '0.5', '0.75', '1'}); % Y-axis custom tick labels
xlabel('time (h)', 'FontSize', 33)
ylabel('OD_{600}', 'FontSize', 33)


% Remove the figure box lines
box off;
% % Set figure size and paper position
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);

saveas(fig1, figFileName)