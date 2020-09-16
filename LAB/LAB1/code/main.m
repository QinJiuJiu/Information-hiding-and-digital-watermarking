% ʵ��1��ͬһ��ˮӡǶ�벻ͬͼ

Tlc = 0.7;
Wr = load('data/data1.mat');
Wr = Wr.Wr;

filename = dir('input');
filename = filename(3:end);
file_num = size(filename);
predict = [];
predict_m = [];
answer = [];
for i = 1:file_num
    for j = -1:1
        path = filename(i).name;
        c = imread(['input/' path]);
        
        [width, height] = size(c);
        
        if j ~= 0
            Cw = E_BLIND(c, Wr, j, 1);
        else
            Cw = c;
        end
        temp = (i-1)*3+2+j;
        answer(temp) = j;
        predict(temp) = D_LC(Cw, Wr);
        if predict(temp) > Tlc
            predict_m(temp) = 1;
        elseif predict(temp) < -Tlc
            predict_m(temp) = -1;
        else
            predict_m(temp) = 0;
        end
    end
end

[accu, false_pos, flase_neg] = False_posneg(answer, predict_m);
fprintf('accuracy = %.2f%%\n', accu*100);
fprintf('False positive rate = %.2f%%\n', false_pos*100);
fprintf('False negative rate = %.2f%%\n', flase_neg*100);

m0 = [];
m1 = [];
no_watermark = [];

y_no_watermark = [0 0 0 0 0 0 0 0 0];
y_m0 = [0 0 0 0 0 0 0 0 0];
y_m1 = [0 0 0 0 0 0 0 0 0];
section = 0;
for i=1:file_num*3
    if answer(i)==0
        no_watermark = [no_watermark predict(i)];
    end
    if answer(i)==1
        m1 = [m1 predict(i)];
    end
    if answer(i)==-1
        m0 = [m0 predict(i)];
    end
end


x = linspace(-3,3,20);
y1 = hist(no_watermark, x);
a = size(no_watermark);
y1 = double(y1)/a(2)*100;
y2 = hist(m0, x);
a = size(m0);
y2 = double(y2)/a(2)*100;
y3 = hist(m1, x);
a = size(m1);
y3 = double(y3)/a(2)*100;
figure,plot(x, y1,x,y2,x,y3);
hold on;
plot([0.7 0.7],[0 100],'k--','LineWidth',1);
hold on;
plot([-0.7 -0.7],[0 100],'k--','LineWidth',1);
hold off;

legend('no watermarke','m=0','m=1','threshold Tlc');
xlabel('Detection value');
ylabel('Percentage of images');
title('��=1,E_BLIND/D_LC���ֵ�ֲ�ͼ','Interpreter','none')

axis([-3 3 0 100]);
set(gca,'XTick',-3:0.5:3);
set(gca,'YTick',0:10:100);