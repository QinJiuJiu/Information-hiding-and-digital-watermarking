m = randi([0,1],[1,8]);
% m = [0,1,0,1,0,0,0,0];
disp(m);
alpha = 2;
seed = 0;
tcc = 0.65;
% 实验3，比较trellis和simple
m = zeros(256,8);
for i = 1:256
    tempi = i - 1;
    tempj = 0;
    while tempi > 0
        m(i,8 - tempj)=mod(tempi,2);
        tempi = floor(tempi/2);
        tempj= tempj+1;
    end
end

        
filename = dir('input');
filename = filename(3:end);
file_num = size(filename);

correct_num_simple = 0;
false_pos_num_simple = 0;
false_neg_num_simple = 0;
error_num_simple = 0;
avg_error_bit_simple = 0;

correct_num_trellis = 0;
false_pos_num_trellis = 0;
false_neg_num_trellis = 0;
error_num_trellis = 0;
avg_error_bit_trellis = 0;

for mi = 1:256
    disp(mi);
    for i = 1:file_num
        path = filename(i).name;
        c = imread(['input/' path]);
        [width, height] = size(c);
        %simple
        Cw = E_BLK_8_Simple(c, m(mi,:), alpha, seed);
        predict = D_BLK_8_Simple(Cw,tcc, seed);
%         disp(predict);

        if predict == m(mi,:)
            correct_num_simple = correct_num_simple + 1;
        elseif length(find(predict==2)) >= 4
            false_neg_num_simple = false_neg_num_simple + 1;
        else
            error_num_simple = error_num_simple + 1;
            for errori = 1:8
                if m(mi,errori) ~= predict(errori)
                    avg_error_bit_simple = avg_error_bit_simple + 1;
                end
            end
        end

        predict = D_BLK_8_Simple(c,tcc, seed);
%         disp(predict);
        if length(find(predict==2)) >= 4
            correct_num_simple = correct_num_simple + 1;
        else
            false_pos_num_simple = false_pos_num_simple + 1;
        end 
        
        %trellis
        Cw = E_BLK_8_Trellis(c, m(mi,:), alpha, seed);
        predict = D_BLK_8_Trellis(Cw,tcc, seed);
%         disp(predict);

        if predict == m(mi,:)
            correct_num_trellis = correct_num_trellis + 1;
        elseif length(find(predict==2)) >= 4
            false_neg_num_trellis = false_neg_num_trellis + 1;
        else
            error_num_trellis = error_num_trellis + 1;
            for errori = 1:8
                if m(mi,errori) ~= predict(errori)
                    avg_error_bit_trellis = avg_error_bit_trellis + 1;
                end
            end
        end

        predict = D_BLK_8_Trellis(c,tcc, seed);
%         disp(predict);
        if length(find(predict==2)) >= 4
            correct_num_trellis = correct_num_trellis + 1;
        else
            false_pos_num_trellis = false_pos_num_trellis + 1;
        end 
    end
end

fprintf('====================SIMPLE====================\n');
fprintf('correct_num = %d,  correct_rate = %2.2f%%\n', correct_num_simple,double(correct_num_simple/(256*41*2)*100));
fprintf('false_pos_num = %d,  false_pos_rate = %2.2f%%\n', false_pos_num_simple,double(false_pos_num_simple/(256*41*2)*100));
fprintf('false_neg_num = %d,  false_neg_rate = %2.2f%%\n', false_neg_num_simple,double(false_neg_num_simple/(256*41*2)*100));
fprintf('error_num = %d,  error_rate = %2.2f%%\n', error_num_simple,double(error_num_simple/(256*41*2)*100));
fprintf('avg_error_bit = %2.2f\n', double(avg_error_bit_simple)/error_num_simple);


fprintf('====================TRELLIS====================\n');
fprintf('correct_num = %d,  correct_rate = %2.2f%%\n', correct_num_trellis,double(correct_num_trellis/(256*41*2)*100));
fprintf('false_pos_num = %d,  false_pos_rate = %2.2f%%\n', false_pos_num_trellis,double(false_pos_num_trellis/(256*41*2)*100));
fprintf('false_neg_num = %d,  false_neg_rate = %2.2f%%\n', false_neg_num_trellis,double(false_neg_num_trellis/(256*41*2)*100));
fprintf('error_num = %d,  error_rate = %2.2f%%\n', error_num_trellis,double(error_num_trellis/(256*41*2)*100));
if error_num_trellis ~= 0
    fprintf('avg_error_bit = %2.2f\n', double(avg_error_bit_trellis)/error_num_trellis);
end

