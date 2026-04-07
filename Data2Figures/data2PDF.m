clear;clc;close all
%% read data
wirte.name = '3-12';
read.data1 = importdata('..\data\placement\leadingS0.00.plt').data;
read.data2 = importdata('..\data\placement\trailingS0.00.plt').data;
read.data3 = importdata('..\data\placement\trailingS0.50.plt').data;
read.data4 = importdata('..\data\force\S0.00.plt').data;
read.data5 = importdata('..\data\force\S0.50.plt').data;
%% plot figures
defaultSettings();
creatBlankFigure([0.05 0.15 0.85 0.55])
position.axe1 = [0.190 0.24 0.30 0.60];
position.axe2 = [0.555 0.24 0.30 0.60];
position.axe3 = [0.680 0.30 0.15 0.30];
% plot figure1 ===========================================================
set(axes,'position',position.axe1);
plot(read.data1(:,1)/pi*2, read.data1(:,3), 'k');
hold on; box off;
plot(read.data2(:,1)/pi*2, read.data2(:,3), 'r');
plot(read.data3(:,1)/pi*2, read.data3(:,3), 'b--');
line([10.25 10.25], [-2 2], 'Color', 'k', 'linewidth', 1.2, 'linestyle', '--');
line([10.50 10.50], [-2 2], 'Color', 'k', 'linewidth', 1.2, 'linestyle', '--');
line([10.75 10.75], [-2 2], 'Color', 'k', 'linewidth', 1.2, 'linestyle', '--');
annotation('textbox',[0.222,0.26,0.12,0.05],'String','A','FontSize', 16,'LineStyle','None','Margin',0);
annotation('textbox',[0.297,0.26,0.12,0.05],'String','B','FontSize', 16,'LineStyle','None','Margin',0);
annotation('textbox',[0.372,0.26,0.12,0.05],'String','C','FontSize', 16,'LineStyle','None','Margin',0);
annotation('textbox',[0.447,0.26,0.12,0.05],'String','D','FontSize', 16,'LineStyle','None','Margin',0);
% plot(read.data1(:,1), read.data1(:,3), '^-', 'Color', 'm', 'MarkerSize', 6, 'MarkerFaceColor', 'm');
% scatter(read.data2(:,1)/pi*2, read.data2(:,2),'ro', 'filled', 'SizeData', 48);
setAxis(gca, [10 11 -1 1], 0.25, 0.5)
setLabels('$t/T$','$y$','')
gd=legend('$G^*=0.0,~y_l$','$G^*=0.0,~y_t$','$G^*=0.5,~y_t$', ...
          'Orientation', 'vertical', 'Interpreter', 'latex');
gd.Position = [0.366,0.700,0.12,0.12];
gd.NumColumns = 1;
% plot figure2 ===========================================================
set(axes,'position',position.axe2);
plot(read.data4(:,1)/pi*2, read.data4(:,2), 'r');
hold on; box off;
plot(read.data5(:,1)/pi*2, read.data5(:,2), 'b');
line([10.25 10.25], [-4 4], 'Color', 'k', 'linewidth', 1.2, 'linestyle', '--');
line([10.50 10.50], [-4 4], 'Color', 'k', 'linewidth', 1.2, 'linestyle', '--');
line([10.75 10.75], [-4 4], 'Color', 'k', 'linewidth', 1.2, 'linestyle', '--');
setAxis(gca, [10 11 -3 3], 0.25, 1.5)
setLabels('$t/T$','$C_D$','')
gd=legend('$G^*=0.0$','$G^*=0.5$', ...
          'Orientation', 'vertical', 'Interpreter', 'latex');
gd.Position = [0.752,0.73,0.10,0.10];
gd.NumColumns = 1;
% write pdf ==============================================================
imwrite(getframe(gcf).cdata, [wirte.name '.png']);
addString();
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
    annotation('textbox',[0.135,0.85,0.2,0.05],'String','(\it{a}\rm{)}','FontSize', 20,'LineStyle','None','Margin',0);
    annotation('textbox',[0.504,0.85,0.2,0.05],'String','(\it{b}\rm{)}','FontSize', 20,'LineStyle','None','Margin',0);
end
