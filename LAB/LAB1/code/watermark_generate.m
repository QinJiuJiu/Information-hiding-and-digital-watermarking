% watermark_generate --Ë®Ó¡Éú³É

function watermark_generate()

for i = 1:40
    Wr = randn(800, 800);
    save(['watermark_800/Wr' num2str(i) '.mat'],'Wr');
end
