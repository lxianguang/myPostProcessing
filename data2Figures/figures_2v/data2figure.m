clear;clc;close all
%% read data
wirte.name = 'example';
read.data1 = importdata('.\data\force1.dat').data;
read.data2 = importdata('.\data\force2.dat').data;
% data processing
Fref = 0.5*1000*1^2*1;
[fourier.fre1, fourier.amp1] = myFFT(read.data1(1000:end,1), read.data1(1000:end,3)/Fref);
[fourier.fre2, fourier.amp2] = myFFT(read.data2(1000:end,1), read.data2(1000:end,3)/Fref);
%% plot figures
defaultSettings();
creatBlankFigure([0.30 0.00 0.40 0.90])
position.axe1 = [0.250 0.58 0.55 0.30];
position.axe2 = [0.250 0.19 0.55 0.30];
% plot figure1 ===========================================================
set(axes,'position',position.axe1);
bar(fourier.fre1, fourier.amp1, 'FaceColor', [0.2 0.6 0.8], 'EdgeColor', 'k', 'BarWidth', 0.5);
hold on; box off;
annotation('textbox', [0.57,0.75,0.12,0.05], 'String', '0.689', 'FontSize', 14, 'LineStyle', 'None', 'Margin', 0);
% plot(fourier.fre1, fourier.amp1, 'r', 'LineWidth', 1.6);
% line([10.25 10.25], [-2 2], 'Color', 'k', 'linewidth', 1.2, 'linestyle', '--');
% plot(read.data1(:,1), read.data1(:,3), '^-', 'Color', 'm', 'MarkerSize', 6, 'MarkerFaceColor', 'm');
% scatter(read.data2(:,1)/pi*2, read.data2(:,2),'ro', 'filled', 'SizeData', 48);
setAxis(gca, [0.3 0.9 0 0.2], 0.1, 0.05)
setLabels('$cf/U_{\infty}$','$Amp/c$','')
% gd=legend('Without cylinder', ...
%           'Behind cylinder', ...
%           'Orientation', 'vertical', 'Interpreter', 'tex', 'FontName', 'Times New Roman', 'FontSize', 16);
% gd.Position = [0.2005, 0.72, 0.28, 0.08];
% gd.NumColumns = 2;
% plot figure2 ===========================================================
set(axes,'position',position.axe2);
bar(fourier.fre2, fourier.amp2, 'FaceColor', [0.2 0.6 0.8], 'EdgeColor', 'k', 'BarWidth', 0.5);
hold on; box off;
annotation('textbox',[0.49,0.37,0.12,0.05], 'String', '0.602', 'FontSize', 14, 'LineStyle', 'None', 'Margin', 0);
annotation('textbox',[0.57,0.31,0.12,0.05], 'String', '0.689', 'FontSize', 14, 'LineStyle', 'None', 'Margin', 0);
setAxis(gca, [0.3 0.9 0 0.8], 0.1, 0.2)
setLabels('$cf/U_{\infty}$','$Amp/c$','')
% write pdf ==============================================================
addString();
imwrite(getframe(gcf).cdata, [wirte.name '.png']);
exportgraphics(gcf,[wirte.name '.pdf'],'resolution', 300, 'ContentType', 'vector') 
% functions ==============================================================
function [] = defaultSettings()
    set(0,'defaultlinelinewidth' ,2);
    set(0,'defaultaxeslinewidth' ,1.5);
    set(0,'DefaultLineMarkerSize',6);
    set(0,'defaultaxesfontsize'  ,16);
    set(0,'defaulttextfontsize'  ,16);
    set(0,'defaultTextFontName', 'Times New Roman');
    set(0,'defaultAxesFontName', 'Times New Roman');
end

function [] = creatBlankFigure(position)
    figure('Units', 'normalized', 'Position', position);
    set(gca, 'XColor', 'w', 'YColor', 'w'); 
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
end

function [] = setAxis(gca,range,dx,dy)
    axis(range) 
    XTick = (range(1):dx:range(2));
    YTick = (range(3):dy:range(4));
    XMinorTick = (range(1):dx/2:range(2));
    YMinorTick = (range(3):dy/2:range(4));
    set(gca, 'XTick', XTick, 'YTick', YTick)
    set(gca, 'XMinorTick', 'on')
    set(gca, 'YMinorTick', 'on')
    ax = gca;
    ax.TickLength = [0.015, 0.02];
    ax.XAxis.MinorTickValues = XMinorTick;
    ax.YAxis.MinorTickValues = YMinorTick;
    line([ax.XLim(2) ax.XLim(2)], [ax.YLim(1) ax.YLim(2)], 'Color', 'k');
    line([ax.XLim(1) ax.XLim(2)], [ax.YLim(2) ax.YLim(2)], 'Color', 'k');
    line([ax.XLim(1) ax.XLim(1)], [ax.YLim(1) ax.YLim(2)], 'Color', 'k');
    line([ax.XLim(1) ax.XLim(2)], [ax.YLim(1) ax.YLim(1)], 'Color', 'k');
end

function [] = setLabels(XLabel,YLabel,Title)
    xlabel(XLabel, 'Interpreter', 'latex');
    ylabel(YLabel, 'Interpreter', 'latex');
    title (Title , 'Interpreter', 'latex');
end

function [] = addString()
    annotation('textbox',[0.140, 0.86, 0.2, 0.05],'String','(\it{a}\rm{)}','FontSize', 18,'LineStyle','None','Margin',0);
    annotation('textbox',[0.140, 0.47, 0.2, 0.05],'String','(\it{b}\rm{)}','FontSize', 18,'LineStyle','None','Margin',0);
end
