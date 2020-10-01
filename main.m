% Script for automatically colouring in images

clear all
close all
clc

addpath('./functions/');
dbstop if error


% file2 = './images/24bit.bmp';
file = './images/monochrome.bmp';
file = './images/mono_simple.bmp';

%% Import Image
imdata = imread(file);
imdata_original = imdata;

%% Create output image
im_out = uint8(zeros([size(imdata),3]));

im_out(:,:,1) = imdata*256;
im_out(:,:,2) = imdata*256;
im_out(:,:,3) = imdata*256;

x = 1;
y = 1;

red = 1;
green = 50;
blue = 125;

while ~isnan(x)
    % Find the white space
    [x,y] = find_white_space(imdata,x,y);
    
    % Colour the white space in
    if ~isnan(x)
%         red = red + 1;     if red > 255; red = 0; end
%         green = green + 1; if green > 255; green = 0; end
%         blue = blue + 1;   if blue > 255; blue = 0; end
        
        red = rand(1) * 255;
        green = rand(1) * 255;
        blue = rand(1) * 255;
              
        
        im_out(x,y,1) = red;
        im_out(x,y,2) = green;
        im_out(x,y,3) = blue;
%         keyboard
        imdata(x,y) = 0;
    end
end


%% Plots
figure(1); clf; hold all; set(gcf,'name','Matt and Jen''s Colouring!');
subplot(1,2,1); ...
    imshow(imdata_original); ...
    title('Original');

subplot(1,2,2); ...
    imshow(im_out); ...
    title('Coloured');






