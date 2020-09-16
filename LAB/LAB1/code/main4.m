% �ҶȽضϣ���ͬͼ��ˮӡ�ֱ�ʵ�ֻҶȽض�/���ض�

filename_wr = dir('watermark_800');
filename_wr = filename_wr(3:end);
file_num_wr = size(filename_wr);
file_num_wr = file_num_wr(1);

filename_c = dir('input');
filename_c = filename_c(3:end);
file_num_c = size(filename_c);
file_num_c = file_num_c(1);

% �ض�/���ض� ͬһ��ͼ��ͬˮӡ�����Ӱ��
accu_plot = [];
false_pos_plot = [];
false_neg_plot = [];

for i=1:file_num_c
    disp(i);
    answer = [];
    predict_answer = [];
    for j=1:file_num_wr
        path_wr = filename_wr(j).name;
        Wr = load(['watermark_800/' path_wr]);
        Wr = Wr.Wr;
        
        path_c = filename_c(i).name;
        c = imread(['input/' path_c]);
        [width, height] = size(c);
        for k=-1:1
            answer = [answer k];
            predict_answer = [predict_answer predict(c, Wr, k)];
        end
    end
    [accu, false_pos, false_neg] = False_posneg(answer, predict_answer);
    accu_plot = [accu_plot accu*100];
    false_pos_plot = [false_pos_plot false_pos*100];
    false_neg_plot = [false_neg_plot false_neg*100];
end

save(['data/accu_plot.mat'],'accu_plot');
save(['data/false_pos_plot.mat'],'false_pos_plot');
save(['data/false_neg_plot.mat'],'false_neg_plot');


x=1:1:41;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
plot(x,accu_plot,'-b',x,false_pos_plot,'--b',x,false_neg_plot,':b'); %���ԣ���ɫ�����
% axis([0,6,0,700])  %ȷ��x����y���ͼ��С
set(gca,'XTick',[0:1:42]) %x�᷶Χ1-6�����1
% set(gca,'YTick',[0:10:100]) %y�᷶Χ0-700�����100
legend('accu','false_pos','false_neg');   %���ϽǱ�ע
% xlabel('ͼ����');  %x����������
% ylabel('�����'); %y����������
hold on;

% �ض�/���ض� ͬһ��ͼ��ͬˮӡ�����Ӱ��
accu_plot = [];
false_pos_plot = [];
false_neg_plot = [];

for i=1:file_num_c
    disp(i);
    answer = [];
    predict_answer = [];
    for j=1:file_num_wr
        path_wr = filename_wr(j).name;
        Wr = load(['watermark_800/' path_wr]);
        Wr = Wr.Wr;
        
        path_c = filename_c(i).name;
        c = imread(['input/' path_c]);
        [width, height] = size(c);
        c = int16(c);
        for k=-1:1
            answer = [answer k];
            predict_answer = [predict_answer predict(c, Wr, k)];
        end
    end
    [accu, false_pos, false_neg] = False_posneg(answer, predict_answer);
    accu_plot = [accu_plot accu*100];
    false_pos_plot = [false_pos_plot false_pos*100];
    false_neg_plot = [false_neg_plot false_neg*100];
    disp(accu*100);
    disp(false_pos*100);
    disp(false_neg*100);
end

save(['data/accu_notruncation_plot.mat'],'accu_plot');
save(['data/false_notruncationpos_plot.mat'],'false_pos_plot');
save(['data/false_notruncationneg_plot.mat'],'false_neg_plot');


x=1:1:41;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
plot(x,accu_plot,'-r',x,false_pos_plot,':r',x,false_neg_plot,'--r'); %���ԣ���ɫ�����
% axis([0,6,0,700])  %ȷ��x����y���ͼ��С
set(gca,'XTick',[0:1:42]) %x�᷶Χ1-6�����1
% set(gca,'YTick',[0:10:100]) %y�᷶Χ0-700�����100
legend('accu','false_pos','false_neg');   %���ϽǱ�ע
xlabel('ͼ����');  %x����������
ylabel('�����'); %y����������