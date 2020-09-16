% E_BLIND --embed a watermark by simple adding a message pattern
% Arguments:
% Co     --image to be watermarked
% m      --one bit message to embed
% alpha  --embedding strength
% wr     --reference pattern
function [result] = E_BLIND(Co, Wr, m, alpha)
result = Co;
[width, height] = size(Co);
% message ֵ�ж�
if m == -1
    Wm = -Wr;
else
    Wm = Wr;
end
% ��=1
Wa = alpha * Wm;
% ���ˮӡ
for i=1:width
    for j=1:height
        result(i,j)=Co(i,j)+Wa(i,j);
    end
end