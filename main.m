% Script for automatically colouring in images

clear all
close all
clc


% Need to run a "checked" logical matrix
% Iterate until finding a zero
%     create a new_pixel vector, 
%     iterate through the new_pixel vector, mark pixel as "checked", store in "to_fill" vector,
%                fill by expanding each pixel out up, down, left and right, if unchecked, addd to new_pixel vector
%                Clear out of new_pixel vector
%     iterate until new_pixel vector becomes empty



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

% while ~isnan(x)
    % Find the white space
    [x,y] = find_white_space(imdata,1,1);
    
    
    
    % Colour the white space in
    if ~isempty(x)
        
            
            %         red = red + 1;     if red > 255; red = 0; end
            %         green = green + 1; if green > 255; green = 0; end
            %         blue = blue + 1;   if blue > 255; blue = 0; end
            
            red = rand(1) * 255;
            green = rand(1) * 255;
            blue = rand(1) * 255;
            
         for ii = 1:numel(x)   
            im_out(x(ii),y(ii),1) = red;
            im_out(x(ii),y(ii),2) = green;
            im_out(x(ii),y(ii),3) = blue;
            %         keyboard
            %imdata(x,y) = 0;
        end
    end
% end


%% Plots
figure(1); clf; hold all; set(gcf,'name','Matt and Jen''s Colouring!');
subplot(1,2,1); ...
    imshow(imdata_original); ...
    title('Original');

subplot(1,2,2); ...
    imshow(im_out); ...
    title('Coloured');






