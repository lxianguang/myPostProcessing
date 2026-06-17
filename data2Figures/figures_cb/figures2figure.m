clear;clc;close all
%% read images
file.outputname = "example.png";
read.image1 = imread(".\figures\Vorticity0000.png");
read.image2 = imread(".\figures\Vorticity0001.png");
read.image3 = imread(".\figures\Vorticity0002.png");
read.image4 = imread(".\figures\Vorticity0003.png");
read.image5 = imread(".\figures\Vorticity0004.png");
read.image6 = imread(".\figures\Vorticity0005.png");
%% parameters
crop.rectangle1 = [0600 0700 1800 800];
line.thickness  = 6;
%% crop images
crop.image1 = imcrop(read.image1, crop.rectangle1);
crop.image2 = imcrop(read.image2, crop.rectangle1);
crop.image3 = imcrop(read.image3, crop.rectangle1);
crop.image4 = imcrop(read.image4, crop.rectangle1);
crop.image5 = imcrop(read.image5, crop.rectangle1);
crop.image6 = imcrop(read.image6, crop.rectangle1);
%% resize images
resize.image1 = imresize(crop.image1, [size(crop.image1, 1), NaN]);
resize.image2 = imresize(crop.image2, [size(crop.image1, 1), NaN]);
resize.image3 = imresize(crop.image3, [size(crop.image1, 1), NaN]);
resize.image4 = imresize(crop.image4, [size(crop.image1, 1), NaN]);
resize.image5 = imresize(crop.image5, [size(crop.image1, 1), NaN]);
resize.image6 = imresize(crop.image6, [size(crop.image1, 1), NaN]);
%% separation lines
temp.hlinewide= size(resize.image1, 2) + size(resize.image4, 2) + 3*line.thickness;
define.vline1 = uint8(zeros(size(crop.image1, 1), line.thickness, 3));
define.hline1 = uint8(zeros(line.thickness,       temp.hlinewide, 3));
%% combine images
combined.image1 = [
                   define.hline1;
                   define.vline1, resize.image1, define.vline1, resize.image4, define.vline1;
                   define.hline1;
                   define.vline1, resize.image2, define.vline1, resize.image5, define.vline1;
                   define.hline1;
                   define.vline1, resize.image3, define.vline1, resize.image6, define.vline1;
                   define.hline1;
                  ];
%% plot 
figure('Units', 'normalized', 'Position', [0.2, 0.12, 0.8, 0.8]);
imshow(combined.image1)
imwrite(combined.image1, file.outputname)