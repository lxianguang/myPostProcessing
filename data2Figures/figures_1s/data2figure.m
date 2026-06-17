clear;clc;close all
%% read data
wirte.name = 'example';
read.data1 = importdata('.\data\Deng2016.plt').data;
read.data2 = importdata('.\data\Koochesfahani1989.plt').data;
read.data3 = importdata('.\data\Koochesfahani2009.plt').data;
read.data4 = importdata('.\data\Mackowski2015.plt').data;
read.data5 = importdata('.\data\PresentNACA0015.plt').data;
read.data6 = importdata('.\data\Ramamurti2001.plt').data;
% data fitting
p1 = polyfit(read.data2(:,1), read.data2(:,2), 3);
p2 = polyfit(read.data5(:,1), read.data5(:,2), 3);
x0 = linspace(0, 15, 151);
y1 = polyval(p1, x0);
y2 = polyval(p2, x0);
%% plot figures
defaultSettings();
creatBlankFigure([0.25 0.15 0.50 0.58])
position.axe1 = [0.22 0.21 0.60 0.66];
% plot figure1 ===========================================================
set(axes,'position',position.axe1);
scatter(read.data2(:,1), read.data2(:,2),'ks', 'filled', 'SizeData', 64);
hold on; box off;
scatter(read.data3(:,1), read.data3(:,2),'kd', 'SizeData', 64, 'LineWidth', 1);
scatter(read.data4(:,1), read.data4(:,2),'ks', 'SizeData', 64, 'LineWidth', 1);
scatter(read.data6(:,1), read.data6(:,2),'kv', 'SizeData', 64, 'LineWidth', 1);
scatter(read.data1(:,1), read.data1(:,2),'kd', 'filled', 'SizeData', 64);
scatter(read.data5(:,1), read.data5(:,2),'ro', 'filled', 'SizeData', 56);
plot(x0, y1, 'k', 'LineWidth', 1.6);
plot(x0, y2, 'r', 'LineWidth', 1.6);
% line([10.25 10.25], [-2 2], 'Color', 'k', 'linewidth', 1.2, 'linestyle', '--');
% scatter(read.data2(:,1)/pi*2, read.data2(:,2),'ro', 'filled', 'SizeData', 48);
% plot(read.data1(:,1), read.data1(:,3), '^-', 'Color', 'm', 'MarkerSize', 6, 'MarkerFaceColor', 'm');
% annotation('textbox', [0.222,0.26,0.12,0.05], 'String', 'A', 'FontSize', 16, 'LineStyle', 'None', 'Margin', 0);
setAxis(gca, [0 15 -0.1 0.3], 5, 0.1)
setLabels('$k$','$C_D$','')
gd=legend('Koochesfahani (1989), NACA0012, Re=12000, EXP', ...
          'Bohl (2009), NACA0012, Re=12600, EXP', ...
          'Mackowski (2015), NACA0012, Re=12000, EXP', ...
          'Ramamurti (2001), NACA0012, Re=12000, CFD', ...
          'Deng (2016), NACA0015, Re=12000, CFD', ...
          'Present, NACA0015, Re=12000, CFD', ...
          'Orientation', 'vertical', 'Interpreter', 'tex', 'FontName', 'Times New Roman', 'FontSize', 11);
gd.Position = [0.247,0.608,0.40,0.24];
gd.NumColumns = 1;
% write pdf ==============================================================
exportgraphics(gcf,[wirte.name '.pdf'],'resolution', 300, 'ContentType', 'vector') 
% addString();
imwrite(getframe(gcf).cdata, [wirte.name '.png']);
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
    annotation('textbox',[0.135,0.85,0.2,0.05],'String','(\it{a}\rm{)}','FontSize', 20,'LineStyle','None','Margin',0);
    annotation('textbox',[0.504,0.85,0.2,0.05],'String','(\it{b}\rm{)}','FontSize', 20,'LineStyle','None','Margin',0);
end
