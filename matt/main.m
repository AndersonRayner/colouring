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
dbstop if error

file = './../images/mono_simple.bmp';
file = './../images/bluey.bmp';
% file = './../images/dragon.bmp';
% file = './../images/elephant.bmp';
% file = './../images/flowers.bmp';
% file = './../images/kind.bmp';
% file = './../images/unicorn.bmp';
% file = './../images/awesomeness.bmp';

file = './../images/pikachu.bmp';
file = './../images/charmander.bmp';
% file = './../images/bulbasaur.bmp';
% file = './../images/squirtle.bmp';



n_colours = 15;
output_dir = fullfile('.','output');
colours = jet(n_colours);  % https://www.mathworks.com/help/matlab/ref/colormap.html
colours = hot(n_colours);    % pikachu
colours = winter(n_colours); % squirtle
colours = summer(n_colours); % bulbasaur
colours = autumn(n_colours); % charmander


% Ideas for getting it to fill randomly
% We'll have to determine all the zones first,
% then randomly fill and save the image.
% Could require lots of work
n_zones = 1277;
randos = rand(n_zones,1);
[~,idx] = sort(randos);
fill_order = 1:n_zones;
fill_order = fill_order(idx)';


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
        zones = zones + 1;
        
        % Select a random colour
        switch (zones)
            case 1
                idx = 12; % background
            case {128, 226}       % eyes
                idx = 13;   % 10
            case {196, 406}       % cheeks
                idx = 8;   % 10
            case 414       % tounge
                idx = 5;   % 5
            otherwise      % random
                idx = ceil(rand*(n_colours-1)); 
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
        
        fprintf('Filled in Zone %4d ( %5d pixels)\n',zones,numel(x));
        
        % Save progress (for making videos)
        if (0)
%         save_file = fullfile(output_dir,['test-',num2str(zones,'%05d'),'.png']);
%         imwrite(im_out,save_file);
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
if ~exist(output_dir,'dir'); mkdir(output_dir); end
save_file = fullfile(output_dir,[datestr(now,'mm-dd-yyyy HH-MM-SS'),'.tiff']);
imwrite(im_out,save_file);




