% predict --根据输入图像和水印返回accu，false pos/neg
% Arguments:
% c      --原始图像
% m      --嵌入的one bit message
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