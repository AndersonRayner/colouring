%% Script for automatically colouring in images
% Iterates until finding a zero
%     create a new_pixel vector,
%     iterate through the new_pixel vector, mark pixel as "checked", store in "to_fill" vector,
%                fill by expanding each pixel out up, down, left and right, if unchecked, addd to new_pixel vector
%                Clear out of new_pixel vector
%     iterate until new_pixel vector becomes empty

clear all
clc

addpath('./functions/');
% dbstop if error

file = './../images/mono_simple.bmp';
file = './../images/bluey.bmp';
file = './../images/dragon.bmp';
% file = './../images/elephant.bmp';
file = './../images/flowers.bmp';
% file = './../images/kind.bmp';
% file = './../images/unicorn.bmp';  
file = './../images/pikachu.bmp';
% file = './../images/awesomeness.bmp';


n_colours = 15;
output_dir = fullfile('.','output');
colours = jet(n_colours);  % https://www.mathworks.com/help/matlab/ref/colormap.html
colours = hot(n_colours);


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

%% Loop through and fill in the image
while ~isempty(x)
    % Find the white space
    % start looking at the previous first white-space found
    [x,y] = find_white_space(imdata,x(1),y(1));
    
    % Colour the white space in
    if ~isempty(x)
        % Select a random colour
        if (zones == 0)
            idx = 12;
        else
            idx = ceil(rand*n_colours);
        end
        
        red = colours(idx,1) * 255;
        green = colours(idx,2) * 255;
        blue = colours(idx,3) * 255;
        
        
        % Fill in all the space
        for ii = 1:numel(x)
            im_out(x(ii),y(ii),1) = red;
            im_out(x(ii),y(ii),2) = green;
            im_out(x(ii),y(ii),3) = blue;
            
            imdata(x(ii),y(ii)) = 0;
            
        end
        
        zones = zones + 1;
        fprintf('Filled in Zone %4d ( %5d pixels)\n',zones,numel(x));
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
if ~exist(output_dir,'dir'); mkdir(output_dir); end
save_file = fullfile(output_dir,[datestr(now,'mm-dd-yyyy HH-MM-SS'),'.tiff']);
imwrite(im_out,save_file);




