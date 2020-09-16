% �ҶȽضϣ���ͬͼ��ض�/���ض�׼ȷ�ʶԱ�ͼ

accu_plot = load('data/accu_plot.mat');
accu_plot = accu_plot.accu_plot;
false_neg_plot = load('data/false_neg_plot.mat');
false_neg_plot = false_neg_plot.false_neg_plot;
false_pos_plot = load('data/false_pos_plot.mat');
false_pos_plot = false_pos_plot.false_pos_plot;


x=1:1:41;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
plot(x,accu_plot,'-b',x,false_pos_plot,':b',x,false_neg_plot,'--b'); %���ԣ���ɫ�����
% axis([0,6,0,700])  %ȷ��x����y���ͼ��С
set(gca,'XTick',[0:1:42]) %x�᷶Χ1-6�����1
% set(gca,'YTick',[0:10:100]) %y�᷶Χ0-700�����100
% legend('accu','false_pos','false_neg');   %���ϽǱ�ע
% xlabel('ͼ����');  %x����������
% ylabel('�����'); %y����������
hold on;


accu_plot = load('data/accu_notruncation_plot.mat');
accu_plot = accu_plot.accu_plot;
false_neg_plot = load('data/false_notruncationneg_plot.mat');
false_neg_plot = false_neg_plot.false_neg_plot;
false_pos_plot = load('data/false_notruncationpos_plot.mat');
false_pos_plot = false_pos_plot.false_pos_plot;

x=1:1:41;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
plot(x,accu_plot,'-r',x,false_pos_plot,':r',x,false_neg_plot,'--r'); %���ԣ���ɫ�����
axis([0,42,0,150])  %ȷ��x����y���ͼ��С
set(gca,'XTick',[0:1:42]) %x�᷶Χ1-6�����1
set(gca,'YTick',[0:10:150]) %y�᷶Χ0-700�����100
legend('accu truncation','false pos rate truncation','false neg rate truncation','accu notruncation','false pos rate notruncation','false neg rate notruncation');   %���ϽǱ�ע
xlabel('ͼ����');  %x����������
ylabel('�����'); %y����������
title('��=1,E_BLIND/D_LC���ֵ�ֲ�ͼ�����ض�/���ض϶Ա�ͼ','Interpreter','none')