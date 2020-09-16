% D_SIMPLE_len --��ȡlenλˮӡ
% Arguments:
% Cw     --�Ѽ���ˮӡ��ͼ��
% seed   --���������
function m = D_SIMPLE_len(Cw, seed, len)
[width, height] = size(Cw);
i = 1;
Wr = zeros(width, height);
m = zeros(1,len);
for i = 1:len
    randn('seed',seed + i);
    Wr = randn(width, height);
    j = 1;
    k = 1;
    product = 0;
    product = product + sum(sum(im2double(Cw).*Wr));
    m(i) = double(product/(width*height));
    if m(i) > 0.1
        m(i) = 1;
    elseif m(i) < -0.1
        m(i) = 0;
    else
        m(i) = 2;
    end
end