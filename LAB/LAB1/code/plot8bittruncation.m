% 灰度截断，不同图像截断/不截断准确率对比图

accu_plot = load('data/accu_plot.mat');
accu_plot = accu_plot.accu_plot;
false_neg_plot = load('data/false_neg_plot.mat');
false_neg_plot = false_neg_plot.false_neg_plot;
false_pos_plot = load('data/false_pos_plot.mat');
false_pos_plot = false_pos_plot.false_pos_plot;


x=1:1:41;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
plot(x,accu_plot,'-b',x,false_pos_plot,':b',x,false_neg_plot,'--b'); %线性，颜色，标记
% axis([0,6,0,700])  %确定x轴与y轴框图大小
set(gca,'XTick',[0:1:42]) %x轴范围1-6，间隔1
% set(gca,'YTick',[0:10:100]) %y轴范围0-700，间隔100
% legend('accu','false_pos','false_neg');   %右上角标注
% xlabel('图像编号');  %x轴坐标描述
% ylabel('检测率'); %y轴坐标描述
hold on;


accu_plot = load('data/accu_notruncation_plot.mat');
accu_plot = accu_plot.accu_plot;
false_neg_plot = load('data/false_notruncationneg_plot.mat');
false_neg_plot = false_neg_plot.false_neg_plot;
false_pos_plot = load('data/false_notruncationpos_plot.mat');
false_pos_plot = false_pos_plot.false_pos_plot;

x=1:1:41;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
plot(x,accu_plot,'-r',x,false_pos_plot,':r',x,false_neg_plot,'--r'); %线性，颜色，标记
axis([0,42,0,150])  %确定x轴与y轴框图大小
set(gca,'XTick',[0:1:42]) %x轴范围1-6，间隔1
set(gca,'YTick',[0:10:150]) %y轴范围0-700，间隔100
legend('accu truncation','false pos rate truncation','false neg rate truncation','accu notruncation','false pos rate notruncation','false neg rate notruncation');   %右上角标注
xlabel('图像编号');  %x轴坐标描述
ylabel('检测率'); %y轴坐标描述
title('α=1,E_BLIND/D_LC检测值分布图——截断/不截断对比图','Interpreter','none')