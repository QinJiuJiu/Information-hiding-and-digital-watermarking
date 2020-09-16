% D_LC --detect a watermark
% Arguments:
% Cw   --watermarked image
% Wr   --reference pattern
function Zlc = D_LC(Cw, Wr)
[width, height] = size(Cw);
Zlc = double(0);
for i=1:width
    for j=1:height
          Zlc = Zlc + (double(Cw(i,j)) * double(Wr(i,j)));
    end
end
Zlc = double(Zlc/(width*height));