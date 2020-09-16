% D_SIMPLE_8 --提取8位水印
% Arguments:
% Cw     --已加入水印的图像
% seed   --随机数种子
function m = D_SIMPLE_8(Cw,seed)
[width, height] = size(Cw);
i = 1;
Wr = zeros(width, height);
m = zeros(1,8);
for i = 1:8
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