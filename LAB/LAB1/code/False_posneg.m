% False_posneg --计算accuracy,false pos/neg rate
% Arguments:
% answer       --正确结果
% predict      --预测结果

function [accu, false_pos, flase_neg] = False_posneg(answer, predict)
false_pos = double(0);
flase_neg = double(0);
accu = double(0);
accu_num = 0;
[~, length] = size(answer);
false_pos_num = 0;
false_neg_num = 0;
for i = 1:length
    if answer(i) == predict(i)
        accu_num = accu_num + 1;
    else
        if (answer(i) == 1 || answer(i) == -1) && predict(i) == 0
            false_neg_num = false_neg_num + 1;
        end
        if (predict(i) == 1 || predict(i) == -1) && answer(i) == 0
            false_pos_num = false_pos_num + 1;
        end
    end
end
accu = double(accu_num)/length;
false_pos = double(false_pos_num)/length;
flase_neg = double(false_neg_num)/length;