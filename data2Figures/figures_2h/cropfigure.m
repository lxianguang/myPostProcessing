%% write figure
run data2figure.m
%% parameters
crop.paras = [0285 0070 1680 0630];
%% read image
read.image = imread([wirte.name '.png']);
%% crop image
crop.image = imcrop(read.image, crop.paras);
%% output
figure('Units', 'normalized', 'Position', [0.1, 0.2, 0.8, 0.8]);
imshow(crop.image)
imwrite(crop.image, [wirte.name '.png'])