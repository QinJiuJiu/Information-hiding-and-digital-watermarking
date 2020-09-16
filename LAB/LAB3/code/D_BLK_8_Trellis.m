% D_BLK_TRELLIS_8 -- 使用相关系数检测基于trellis code块编码8位信息
% Arguments:
% Cw -- 加水印后的图像
% tcc -- 检测阈值
% seed -- 随机数种子
function m_best = D_BLK_8_Trellis(Cw, tcc, seed)
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
% TrellisDemodulate
lc0 = zeros(1,8);
lc1 = zeros(1,8);
lc0 = lc0 - 1;
lc0(1) = 0;
% temp = lc0(2);
m0 = zeros(8,8);
m1 = zeros(8,8);
stateSystem = [[0,1];[2,3];[4,5];[6,7];[0,1];[2,3];[4,5];[6,7]];
for i=1:10
    lc1 = zeros(1,8);
    lc1 = lc1 - 1;
    for state = 0:7
        if lc0(state + 1) ~= -1
            Wr = zeros(8, 8);
            % rand生成Wr函数
            randn('seed',seed + state * 10 + i - 1);
            Wr = randn(8, 8);
            lc = sum(sum(v.*Wr))/64;
            next = stateSystem(state+1, 1);
            if lc1(next+1) == -1 || lc1(next+1) < lc0(state+1) - lc
                lc1(next+1) = lc0(state+1) - lc;
                m1(next+1,:) = m0(state+1,:);
            end
            if i <= 8
                next = stateSystem(state+1, 2);
                if lc1(next+1) == -1 || lc1(next+1) < lc0(state+1) + lc
                    lc1(next+1) = lc0(state+1) + lc;
                    m1(next+1,:) = m0(state+1,:);% ???
                    m1(next+1,i) = 1;
                end
            end
        end  
    end
    lc0 = lc1;
    m0 = m1;   
end
bestState = 0;
for state=1:7
    if lc0(state+1) > lc0(bestState+1)
        bestState = state;
    end
end
m_best = m0(bestState+1,:);
%TrellisModulate
Wm = zeros(8,8);
state = 0;
stateSystem = [[0,1];[2,3];[4,5];[6,7];[0,1];[2,3];[4,5];[6,7]];

for i=1:10
    Wr = zeros(8, 8);
    % rand生成Wr函数
    randn('seed',seed + state * 10 + i - 1);
    Wr = randn(8, 8);
    if i<=8 && m_best(i) == 1
        Wm = Wm + Wr;
        state = stateSystem(state+1, 2);
    else
        Wm = Wm - Wr;
        state = stateSystem(state+1, 1);
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
    m_best = m + 2;
end