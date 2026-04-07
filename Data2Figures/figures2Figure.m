clear;clc;close all
%% read images
file.outputname = "3-4.png";
read.image1 = imread("..\Velocity\K1.50S0.00.png");
read.image2 = imread("..\Velocity\K1.50S0.20.png");
read.image3 = imread("..\Velocity\K1.50S0.50.png");
read.image4 = imread("..\Vortex\K1.50S0.00.png"  );
read.image5 = imread("..\Vortex\K1.50S0.20.png"  );
read.image6 = imread("..\Vortex\K1.50S0.50.png"  );
read.image7 = imread("..\Plate\K1.50S0.00.png"   );
read.image8 = imread("..\Plate\K1.50S0.20.png"   );
read.image9 = imread("..\Plate\K1.50S0.50.png"   );
%% parameters
crop.rectangle1 = [291 344 1434 1019];
crop.rectangle2 = [500 725 949  359 ];
crop.rectangle3 = [20  50  899  799 ];
line.thickness  = 8;
%% crop images
crop.image1 = imcrop(read.image1, crop.rectangle1);
crop.image2 = imcrop(read.image2, crop.rectangle1);
crop.image3 = imcrop(read.image3, crop.rectangle1);
crop.image4 = imcrop(read.image4, crop.rectangle2);
crop.image5 = imcrop(read.image5, crop.rectangle2);
crop.image6 = imcrop(read.image6, crop.rectangle2);
crop.image7 = imcrop(read.image7, crop.rectangle3);
crop.image8 = imcrop(read.image8, crop.rectangle3);
crop.image9 = imcrop(read.image9, crop.rectangle3);
%% resize images
resize.image1 = imresize(crop.image1, [size(crop.image1, 1), NaN]);
resize.image2 = imresize(crop.image2, [size(crop.image1, 1), NaN]);
resize.image3 = imresize(crop.image3, [size(crop.image1, 1), NaN]);
resize.image4 = imresize(crop.image4, [size(crop.image1, 1), NaN]);
resize.image5 = imresize(crop.image5, [size(crop.image1, 1), NaN]);
resize.image6 = imresize(crop.image6, [size(crop.image1, 1), NaN]);
resize.image7 = imresize(crop.image7, [size(crop.image1, 1), NaN]);
resize.image8 = imresize(crop.image8, [size(crop.image1, 1), NaN]);
resize.image9 = imresize(crop.image9, [size(crop.image1, 1), NaN]);
%% set separation lines
temp.hlinewide= size(resize.image1, 2) + size(resize.image4, 2) + size(resize.image7, 2) + 4*line.thickness;
define.vline1 = uint8(zeros(size(crop.image1, 1), line.thickness, 3));
define.hline1 = uint8(zeros(line.thickness,       temp.hlinewide, 3));
%% combine images
combined.image1 = [
                   define.hline1;
                   define.vline1, resize.image1, define.vline1, resize.image4, define.vline1, resize.image7, define.vline1;
                   define.hline1;
                   define.vline1, resize.image2, define.vline1, resize.image5, define.vline1, resize.image8, define.vline1;
                   define.hline1;
                   define.vline1, resize.image3, define.vline1, resize.image6, define.vline1, resize.image9, define.vline1;
                   define.hline1;
                  ];


%% plot 
figure('Units', 'normalized', 'Position', [0.1, 0.2, 0.8, 0.8]);
imshow(combined.image1)
imwrite(combined.image1, file.outputname)