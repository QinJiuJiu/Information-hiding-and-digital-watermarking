% calculate_50gray --输出黑白像素值比例大于50%的图

function calculate_50gray()
filename = dir('input');
filename = filename(3:end);
file_num = size(filename);
for i=1:file_num
    path = filename(i).name;
    % disp(path);
    c = imread(['input/' path]);
    [width, height] = size(c);
    count = 0;
    for j=1:width
        for k=1:height
            if c(j,k)>=255 || c(j,k)<1
                count = count + 1;
            end
        end
    end
    proportion = double(count)/(width*height);
    if proportion > 0.5
        disp(path);
        disp(proportion);
    end
end

    
    