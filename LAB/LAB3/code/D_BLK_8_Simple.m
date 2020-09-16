% D_BLK_8_Simple -- 使用相关系数检测基于块编码8位信息
% Arguments:
% Cw -- 加水印后的图像
% tcc -- 检测阈值
% seed -- 随机数种子
function m = D_BLK_8_Simple(Cw, tcc, seed)
[height, width] = size(Cw);
% Extract Mark
v = zeros(8,8);
n = zeros(8,8);
temp = 0;
for i=1:height
    for j=1:width
        index_i = mod(i-1,8) + 1;
        index_j = mod(j-1,8) + 1;
        v(index_i, index_j) =  double(v(index_i, index_j)) + double(Cw(i,j));
        n(index_i, index_j) = n(index_i, index_j) + 1;
    end
end
v = double(v)./double(n);
% SimpleDemodulate
Wr = zeros(8,8);
m = zeros(1,8);
for i = 1:8
    randn('seed',seed + i);
    Wr = randn(8,8);
    product = 0;
    product = double(product) + sum(sum(im2double(v).*Wr));
    m(i) = double(double(product)/(8*8));
    if m(i) > 0.1
        m(i) = 1;
    elseif m(i) < -0.1
        m(i) = 0;
    else
        m(i) = 2;
    end
end
% Simple modulate
Wm = zeros(8, 8);
for i=1:8
    Wr = zeros(8,8);
    % rand生成Wr函数
    randn('seed',seed + i);
    Wr = randn(8,8);

    if m(i) == 1
        Wm = Wm + Wr;
    else
        Wm = Wm - Wr;
    end
end
% corrcoef
mean_v = mean(v);
v = v - mean_v;
mean_Wm = mean(Wm);
Wm = Wm - mean_Wm;

vWm = sum(sum(v.*Wm));
vv = sum(sum(v.*v));
WmWm = sum(sum(Wm.*Wm));
ESSENTIALLY_ZERO = 0.0000001;
if abs(vv*WmWm) < ESSENTIALLY_ZERO
    cc = 0;
else
    cc = vWm / sqrt(vv*WmWm);
end
% disp(cc);
if cc < tcc
    m = zeros(1,8);
    m = m + 2;
end