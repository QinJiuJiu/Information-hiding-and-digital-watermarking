alpha = sqrt(8);
seed = 0;
% 实验3，信息长度对准确率影响

filename = dir('input');
filename = filename(3:end);
file_num = size(filename);
[width, height] = size(c);
correct_list = [];
false_pos_list = [];
false_neg_list = [];
error_list = [];
temp = 8;
x = [];
for i = 1:50
    x = [x, temp];
    m = randi([0,1],[1,temp]);
    correct_num = 0;
    false_pos_num = 0;
    false_neg_num = 0;
    error_num = 0;
    disp(i);
    for j = 1:file_num
        path = filename(j).name;
        c = imread(['input/' path]);

        [width, height] = size(c);
        Cw = E_SIMPLE_len(c, m, alpha, seed, temp);
        predict = D_SIMPLE_len(Cw, seed, temp);

        if predict == m
            correct_num = correct_num + 1;
        elseif length(find(predict==2)) >= 4
            false_neg_num = false_neg_num + 1;
        else
            error_num = error_num + 1;
        end

        predict = D_SIMPLE_len(c, seed, i*8);

        if length(find(predict==2)) >= 4
            correct_num = correct_num + 1;
        else
            false_pos_num = false_pos_num + 1;
        end 
    end
    fprintf('correct_num = %d,  correct_rate = %2.2f%%\n', correct_num,double(correct_num/82*100));
    fprintf('false_pos_num = %d,  false_pos_rate = %2.2f%%\n', false_pos_num,double(false_pos_num/82*100));
    fprintf('false_neg_num = %d,  false_neg_rate = %2.2f%%\n', false_neg_num,double(false_neg_num/82*100));
    fprintf('error_num = %d,  error_rate = %2.2f%%\n', error_num,double(error_num/82*100));
    correct_list = [correct_list, correct_num/82*100];
    false_pos_list = [false_pos_list, false_pos_num/82*100];
    false_neg_list = [false_neg_list, false_neg_num/82*100];
    error_list = [error_list, error_num/82*100];
    temp = temp + 8;
end

plot(x,correct_list,'r',x,false_pos_list,'b',x,false_neg_list,'g',x,error_list,'m'); %线性，颜色，标记
% axis([0,6,0,700])  %确定x轴与y轴框图大小
set(gca,'XTick',x) %x轴范围1-6，间隔1
% set(gca,'YTick',[0:10:100]) %y轴范围0-700，间隔100
legend('accu','false_pos','false_neg','error');   %右上角标注
xlabel('信息位数');  %x轴坐标描述
ylabel('检测率'); %y轴坐标描述
title( '信息长度增加对检测准确率的影响');
