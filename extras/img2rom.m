function  [rgb8bit,rgb8] = img2rom(img)


%read image
image = imread(img);

%split r,g,b
r = image(:, :, 1);
g = image(:, :, 2);
b = image(:, :, 3);


%convert r,g,b to fixed point for bitslice
rfi = fi(r);
gfi = fi(g);
bfi = fi(b);

% take 3 LSB for r,g
r3 = bitsliceget(rfi,3,1);
g3 = bitsliceget(gfi,3,1);
% take 2 LSB for b
b2 = bitsliceget(bfi,2,1);
 
%concatenate into an 8bit
rgb =bitconcat(r3,g3,b2);
%cast to uint8 for safety
rgb8 = uint8(rgb);

%transpose to get a 1d matrix for 
%formatting purposes
rgb = transpose(rgb8);
rgb8bit = rgb(:);


name_ext_cell = strsplit(img, '.');
%make filename string with coe extension
filename = sprintf('%s.rom', string(name_ext_cell(1)));

fid = fopen(filename,'wt');
%fprintf(fid,  'memory_initialization_radix = 10; \n memory_initialization_vector =\n');
dlmwrite(filename,rgb8bit,'-append');

%matlab code doesn't add commas 
%or semicolon at end

end

