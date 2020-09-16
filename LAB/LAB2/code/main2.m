alpha = sqrt(8);
seed = 0;
% 实验2，同一张图嵌入不同水印

c = imread('input/man.tiff');
[width, height] = size(c);
%predict = zeros(8);
correct_num = 0;
false_pos_num = 0;
false_neg_num = 0;
error_num = 0;
for i = 1:40
    m = randi([0,1],[1,8]);
    disp(m);
    
    Cw = E_SIMPLE_8(c, m, alpha, seed * (i - 1));
    predict = D_SIMPLE_8(Cw, seed * (i - 1));
    disp(predict);
    if predict == m
        correct_num = correct_num + 1;
    elseif length(find(predict==2)) >= 4
        false_neg_num = false_neg_num + 1;
    else
        error_num = error_num + 1;
    end
    
    predict = D_SIMPLE_8(c, seed * (i - 1));
    disp(predict);
    if length(find(predict==2)) >= 4
        correct_num = correct_num + 1;
    else
        false_pos_num = false_pos_num + 1;
    end 
    
end
fprintf('correct_num = %d,  correct_rate = %2.2f%%\n', correct_num,double(correct_num/80*100));
fprintf('false_pos_num = %d,  false_pos_rate = %2.2f%%\n', false_pos_num,double(false_pos_num/80*100));
fprintf('false_neg_num = %d,  false_neg_rate = %2.2f%%\n', false_neg_num,double(false_neg_num/80*100));
fprintf('error_num = %d,  error_rate = %2.2f%%\n', error_num,double(error_num/80*100));
