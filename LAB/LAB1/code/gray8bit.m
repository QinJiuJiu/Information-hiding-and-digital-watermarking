filename = dir('watermark');
filename = filename(3:end);
file_num = size(filename);
Tlc = 0.7;
c = imread('input/8.gif');
disp('*****************Í¼Æ¬8.gif*****************')
c_nontruncation = int8(c);
[width, height] = size(c);
% ½Ø¶Ï
predict = [];
predict_m = [];
answer = [];
for i = 1:40
    path = filename(i).name;
    Wr = load(['watermark/' path]);
    Wr = Wr.Wr;
    for j = -1:1
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
fprintf('================»Ò¶È½Ø¶Ï================\n');
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
for i=1:120
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
subplot(1,2,1),plot(x, y1,x,y2,x,y3);
hold on;
plot([0.7 0.7],[0 100],'k--','LineWidth',1);
hold on;
plot([-0.7 -0.7],[0 100],'k--','LineWidth',1);
hold off;

legend('no watermarke','m=0','m=1','threshold Tlc');
xlabel('Detection value');
ylabel('Percentage of images');
title('8.gif ¦Á=1,E_BLIND/D_LC¼ì²âÖµ·Ö²¼Í¼¡ª¡ª½Ø¶Ï','Interpreter','none')

axis([-3 3 0 100]);
set(gca,'XTick',-3:0.5:3);
set(gca,'YTick',0:10:100);




% ²»½Ø¶Ï
predict = [];
predict_m = [];
answer = [];
bit8gray = [];
gray_correct = [];
gray_wrong = [];
for i = 1:40
    path = filename(i).name;
    Wr = load(['watermark/' path]);
    Wr = Wr.Wr;
    for j = -1:1
        if j ~= 0
            Cw = E_BLIND(c_nontruncation, Wr, j, 1);
        else
            Cw = c_nontruncation;
        end
        
        temp = (i-1)*3+2+j;
        answer(temp) = j;
        bit8gray(temp) = 0;
        for grayi=1:width
            for grayj=1:height
                if Cw(grayi,grayj)>=256 || Cw(grayi,grayj)<0
                    bit8gray(temp) = bit8gray(temp) + 1;
                end
            end
        end
        
        predict(temp) = D_LC(Cw, Wr);
        if predict(temp) > Tlc
            predict_m(temp) = 1;
        elseif predict(temp) < -Tlc
            predict_m(temp) = -1;
        else
            predict_m(temp) = 0;
        end
        if predict_m(temp) == answer(temp)
            gray_correct = [gray_correct bit8gray(temp)];
        end
        if predict_m(temp) ~= answer(temp)
            gray_wrong = [gray_wrong bit8gray(temp)];
        end
    end
end

[accu, false_pos, flase_neg] = False_posneg(answer, predict_m);
fprintf('================ÎÞ»Ò¶È½Ø¶Ï================\n');
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
for i=1:120
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
subplot(1,2,2),plot(x, y1,x,y2,x,y3);
hold on;
plot([0.7 0.7],[0 100],'k--','LineWidth',1);
hold on;
plot([-0.7 -0.7],[0 100],'k--','LineWidth',1);
hold off;

legend('no watermarke','m=0','m=1','threshold Tlc');
xlabel('Detection value');
ylabel('Percentage of images');
title('8.gif ¦Á=1,E_BLIND/D_LC¼ì²âÖµ·Ö²¼Í¼¡ª¡ª²»½Ø¶Ï','Interpreter','none')

axis([-3 3 0 100]);
set(gca,'XTick',-3:0.5:3);
set(gca,'YTick',0:10:100);

%% ºÚ°×ÏñËØÖµ´óÓÚ50%
filename = dir('watermark');
filename = filename(3:end);
file_num = size(filename);
Tlc = 0.7;
c = imread('input/rec_Hotelling.bmp');
disp('*****************Í¼Æ¬rec_Hotelling.bmp*****************')
c_nontruncation = int16(c);
[width, height] = size(c);
% ½Ø¶Ï
predict = [];
predict_m = [];
answer = [];
for i = 1:40
    path = filename(i).name;
    Wr = load(['watermark/' path]);
    Wr = Wr.Wr;
    for j = -1:1
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
fprintf('================»Ò¶È½Ø¶Ï================\n');
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
for i=1:120
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

figure;

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
subplot(1,2,1),plot(x, y1,x,y2,x,y3);
hold on;
plot([0.7 0.7],[0 100],'k--','LineWidth',1);
hold on;
plot([-0.7 -0.7],[0 100],'k--','LineWidth',1);
hold off;

legend('no watermarke','m=0','m=1','threshold Tlc');
xlabel('Detection value');
ylabel('Percentage of images');
title('rec_Hotelling ¦Á=1,E_BLIND/D_LC¼ì²âÖµ·Ö²¼Í¼¡ª¡ª½Ø¶Ï','Interpreter','none')

axis([-3 3 0 100]);
set(gca,'XTick',-3:0.5:3);
set(gca,'YTick',0:10:100);




% ²»½Ø¶Ï
predict = [];
predict_m = [];
answer = [];
bit8gray = [];
gray_correct = [];
gray_wrong = [];
for i = 1:40
    path = filename(i).name;
    Wr = load(['watermark/' path]);
    Wr = Wr.Wr;
    for j = -1:1
        if j ~= 0
            Cw = E_BLIND(c_nontruncation, Wr, j, 1);
        else
            Cw = c_nontruncation;
        end
        
        temp = (i-1)*3+2+j;
        answer(temp) = j;
        bit8gray(temp) = 0;
        for grayi=1:width
            for grayj=1:height
                if Cw(grayi,grayj)>=256 || Cw(grayi,grayj)<0
                    bit8gray(temp) = bit8gray(temp) + 1;
                end
            end
        end
        
        predict(temp) = D_LC(Cw, Wr);
        if predict(temp) > Tlc
            predict_m(temp) = 1;
        elseif predict(temp) < -Tlc
            predict_m(temp) = -1;
        else
            predict_m(temp) = 0;
        end
        if predict_m(temp) == answer(temp)
            gray_correct = [gray_correct bit8gray(temp)];
        end
        if predict_m(temp) ~= answer(temp)
            gray_wrong = [gray_wrong bit8gray(temp)];
        end
    end
end

[accu, false_pos, flase_neg] = False_posneg(answer, predict_m);
fprintf('================ÎÞ»Ò¶È½Ø¶Ï================\n');
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
for i=1:120
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
subplot(1,2,2),plot(x, y1,x,y2,x,y3);
hold on;
plot([0.7 0.7],[0 100],'k--','LineWidth',1);
hold on;
plot([-0.7 -0.7],[0 100],'k--','LineWidth',1);
hold off;

legend('no watermarke','m=0','m=1','threshold Tlc');
xlabel('Detection value');
ylabel('Percentage of images');
title('rec_Hotelling ¦Á=1,E_BLIND/D_LC¼ì²âÖµ·Ö²¼Í¼¡ª¡ª²»½Ø¶Ï','Interpreter','none')

axis([-3 3 0 100]);
set(gca,'XTick',-3:0.5:3);
set(gca,'YTick',0:10:100);