% Script for automatically colouring in images

clear all
% close all
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
file = './images/unicorn.bmp';
% file = './images/mono_simple.bmp';


n_colours = 15;


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
zones = 0;


colours = parula(n_colours);  % https://www.mathworks.com/help/matlab/ref/colormap.html
colours = jet(n_colours);  % https://www.mathworks.com/help/matlab/ref/colormap.html


while ~isempty(x)
    % Find the white space
    fprintf('Starting search at (%5d,%5d)\n',x(1),y(1));
    [x,y] = find_white_space(imdata,x(1),y(1));
    
    
    
    % Colour the white space in
    if ~isempty(x)
        
            
            %         red = red + 1;     if red > 255; red = 0; end
            %         green = green + 1; if green > 255; green = 0; end
            %         blue = blue + 1;   if blue > 255; blue = 0; end
            
%             keyboard
            
            idx = ceil(rand*n_colours);
            
            red = colours(idx,1) * 255;
            green = colours(idx,2) * 255;
            blue = colours(idx,3) * 255;
            
         for ii = 1:numel(x)   
            im_out(x(ii),y(ii),1) = red;
            im_out(x(ii),y(ii),2) = green;
            im_out(x(ii),y(ii),3) = blue;
            
            imdata(x(ii),y(ii)) = 0;
            
            zones = zones + 1;
        end
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

%% Save output
save_file = fullfile('.','output',[datestr(now,'mm-dd-yyyy HH-MM-SS'),'.tiff']);
imwrite(im_out,save_file);





