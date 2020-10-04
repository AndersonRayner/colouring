%Script to show examples of coloring!!

close all
clear all

addpath('./functions/');

%Path to original image
filename = './../images/unicorn.bmp';


%% Color image in different styles
im_rand = colorImage(filename, 'random', 'jet');
im_upward = colorImage(filename, 'upward', []);
im_size = colorImage(filename, 'size', []);

%% Plot Colored Images
figure;
subplot(1, 3, 1)
imshow(im_rand)
title('Random')
subplot(1, 3, 2)
imshow(im_upward)
title('Upward')
subplot(1, 3, 3)
imshow(im_size)
title('By Size')
