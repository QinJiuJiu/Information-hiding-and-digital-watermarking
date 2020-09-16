filename = dir('input');
filename = filename(3:end);
file_num = size(filename);
%predict = zeros(8);
correct_num = 0;
false_pos_num = 0;
false_neg_num = 0;
error_num = 0;
for i = 1:file_num
    path = filename(i).name;
    c = imread(['input/' path]);
    csvwrite(['img',num2str(i),'.csv'],c)
end