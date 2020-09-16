% predict --��������ͼ���ˮӡ����accu��false pos/neg
% Arguments:
% c      --ԭʼͼ��
% m      --Ƕ���one bit message
% wr     --reference pattern
function result=predict(c, Wr, m)
Tlc = 0.7;
if m ~= 0
    Cw = E_BLIND(c, Wr, m, 1);
else
    Cw = c;
end
predict_result = D_LC(Cw, Wr);
if predict_result > Tlc
    result = 1;
elseif predict_result < -Tlc
    result = -1;
else
    result = 0;
end