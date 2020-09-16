% trellis²âÊÔ
m = randi([0,1],[1,8]);
% m = [1,1,1,1,1,1,1,1];
% m = [0,0,1,0,0,0,1,0];
% m = [0,0,1,0,1,1,0,0];
m = [0,0,0,0,0,0,1,0];
fprintf(' m =');
disp(m);
alpha = 2;
seed = 0;
tcc = 0.65;

filename = dir('input');
filename = filename(3:end);
file_num = size(filename);
%predict = zeros(8);
correct_num = 0;
false_pos_num = 0;
false_neg_num = 0;
error_num = 0;
avg_error_bit_trellis = 0;
for i = 1:file_num
    path = filename(i).name;
    c = imread(['input/' path]);

    Cw = E_BLK_8_Trellis(c, m, alpha, seed);
    predict = D_BLK_8_Trellis(Cw,tcc, seed);
%     disp(predict);
    if predict == m
        correct_num = correct_num + 1;
    elseif length(find(predict==2)) >= 4
        false_neg_num = false_neg_num + 1;
    else
        error_num = error_num + 1;
        for errori = 1:8
            if m(errori) ~= predict(errori)
                avg_error_bit_trellis = avg_error_bit_trellis + 1;
            end
        end
    end
    
    predict = D_BLK_8_Trellis(c,tcc, seed);
%     disp(predict);
    if length(find(predict==2)) >= 4
        correct_num = correct_num + 1;
    else
        false_pos_num = false_pos_num + 1;
    end 
    
end
fprintf('====================TRELLIS WITH PAD====================\n');
fprintf('correct_num = %d,  correct_rate = %2.2f%%\n', correct_num,double(correct_num/(2*41)*100));
fprintf('false_pos_num = %d,  false_pos_rate = %2.2f%%\n', false_pos_num,double(false_pos_num/(2*41)*100));
fprintf('false_neg_num = %d,  false_neg_rate = %2.2f%%\n', false_neg_num,double(false_neg_num/(2*41)*100));
fprintf('error_num = %d,  error_rate = %2.2f%%\n', error_num,double(error_num/(2*41)*100));
if error_num ~= 0
    fprintf('avg_error_bit = %2.2f\n', double(avg_error_bit_trellis)/error_num);
end