% 灰度截断，不同图像、水印分别实现灰度截断/不截断

filename_wr = dir('watermark_800');
filename_wr = filename_wr(3:end);
file_num_wr = size(filename_wr);
file_num_wr = file_num_wr(1);

filename_c = dir('input');
filename_c = filename_c(3:end);
file_num_c = size(filename_c);
file_num_c = file_num_c(1);

% 截断/不截断 同一张图不同水印检测率影响
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


x=1:1:41;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
plot(x,accu_plot,'-b',x,false_pos_plot,'--b',x,false_neg_plot,':b'); %线性，颜色，标记
% axis([0,6,0,700])  %确定x轴与y轴框图大小
set(gca,'XTick',[0:1:42]) %x轴范围1-6，间隔1
% set(gca,'YTick',[0:10:100]) %y轴范围0-700，间隔100
legend('accu','false_pos','false_neg');   %右上角标注
% xlabel('图像编号');  %x轴坐标描述
% ylabel('检测率'); %y轴坐标描述
hold on;

% 截断/不截断 同一张图不同水印检测率影响
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


x=1:1:41;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
plot(x,accu_plot,'-r',x,false_pos_plot,':r',x,false_neg_plot,'--r'); %线性，颜色，标记
% axis([0,6,0,700])  %确定x轴与y轴框图大小
set(gca,'XTick',[0:1:42]) %x轴范围1-6，间隔1
% set(gca,'YTick',[0:10:100]) %y轴范围0-700，间隔100
legend('accu','false_pos','false_neg');   %右上角标注
xlabel('图像编号');  %x轴坐标描述
ylabel('检测率'); %y轴坐标描述