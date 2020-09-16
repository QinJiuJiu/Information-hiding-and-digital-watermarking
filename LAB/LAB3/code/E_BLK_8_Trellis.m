% E_BLK_8_Trellis -- 将编码的8位信息嵌入到基于trellis code块的水印中
% Arguments:
% Co -- 待加水印的图片
% m -- 8位信息
% alpha -- 嵌入强度
% seed -- 随机数种子
function Cw = E_BLK_8_Trellis(Co, m, alpha, seed)
[height, width] = size(Co);
Co = im2double(Co);
% Trellis modulate
Wm = zeros(8,8);
state = 0;
stateSystem = [[0,1];[2,3];[4,5];[6,7];[0,1];[2,3];[4,5];[6,7]];

for i=1:10
    Wr = zeros(8, 8);
    % rand生成Wr函数
    randn('seed',seed + state * 10 + i - 1);
    Wr = randn(8, 8);
    if i<=8 && m(i) == 1
        Wm = Wm + Wr;
        state = stateSystem(state+1, 2);
    else
        Wm = Wm - Wr;
        state = stateSystem(state+1, 1);
    end  
end
% normalize
Wm_mean = mean(mean(Wm));
Wm = Wm - Wm_mean;
Wm_std = std2(Wm);
Wm = Wm / Wm_std;
% end

% Extract Mark
vo = zeros(8,8);
n = zeros(8,8);
temp = 0;
for i=1:height
    for j=1:width
        index_i = mod(i-1,8) + 1;
        index_j = mod(j-1,8) + 1;
        vo(index_i, index_j) = vo(index_i, index_j) + double(Co(i,j));
        n(index_i, index_j) = n(index_i, index_j) + 1;
    end
end
vo = double(vo)./double(n);

% MixBlind
vw = zeros(8,8);
vw = double(vo) + double(alpha * Wm);

% InvExtractMark
nvo = zeros(8,8);
n = zeros(8,8);
for i=1:height
    for j=1:width
        index_i = mod(i-1,8) + 1;
        index_j = mod(j-1,8) + 1;
        nvo(index_i, index_j) = nvo(index_i, index_j) + double(Co(i,j));
        n(index_i, index_j) = n(index_i, index_j) + 1;
    end
end
delta = zeros(8,8);
delta = double(n).*vw - double(nvo);
Cw = zeros(height, width);
for i=1:height
    for j=1:width
        index_i = mod(i-1,8) + 1;
        index_j = mod(j-1,8) + 1;
        oldPixel = double(Co(i,j));
        newPixel = double(Co(i,j)) + double(delta(index_i,index_j))./double(n(index_i,index_j));
        if newPixel > 255
            newPixel = 255;
        end
        if newPixel < 0 
            newPixel = 0;
        end
        Co(i, j) = newPixel;
        n(index_i,index_j) = n(index_i,index_j) - 1;
        delta(index_i,index_j) = delta(index_i,index_j) - (Co(i,j) - oldPixel);
    end
end
Cw = Co;