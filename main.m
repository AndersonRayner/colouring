% Script for automatically colouring in images

clear all
close all
clc

addpath('./functions/');


file = './images/monochrome.bmp';

%% Import Image
imdata = imread(file);

%% Create output image
im_out = zeros(size(imdata));


%% Plots
figure(1); clf; hold all; set(gcf,'name','Matt and Jen''s Colouring!');
subplot(1,2,1); ...
    imshow(imdata); ...
    title('Original');

subplot(1,2,2); ...
    imshow(im_out); ...
    title('Coloured');






