% E_SIMPLE_8 --��ͼ���м���8λˮӡ
% Arguments:
% Co     --������ˮӡ��ͼ��
% m      --8λ��Ϣ
% alpha  --����ˮӡǿ��
% seed   --���������
function Cw = E_SIMPLE_8(Co, m, alpha, seed)
[width, height] = size(Co);
Wm = zeros(width, height);
Cw = zeros(width, height);
i = 1;
for i=1:8
    Wr = zeros(width, height);
    % rand����Wr����
    randn('seed',seed + i);
    Wr = randn(width, height);

    if m(i) == 1
        Wm = Wm + Wr;
    else
        Wm = Wm - Wr;
    end
end
% normalize
Wm_mean = mean(mean(Wm));
Wm = Wm - Wm_mean;
Wm_std = std2(Wm);
Wm = Wm / Wm_std;
% end
Cw = im2double(Co) + alpha * Wm;    
for i=1:width
    for j=1:height
        if Cw(i,j)>255
            Cw(i,j)=255;
        end
        if Cw(i,j)<0
            Cw(i,j)=0;
        end
    end
end

end
