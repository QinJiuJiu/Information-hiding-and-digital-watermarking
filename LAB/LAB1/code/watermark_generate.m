% watermark_generate --ˮӡ����

function watermark_generate()

for i = 1:40
    Wr = randn(800, 800);
    save(['watermark_800/Wr' num2str(i) '.mat'],'Wr');
end
