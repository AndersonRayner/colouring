function [coloredIm] = colorImage(filename,coloringStyle, cmap)
%Binarizes and fills in colors an image paint bucket style.
%By Jen Cardona 2020
%   INPUTS:
%       - filename - filename (including path) as a string
%       - coloringStyle - style to be used for coloring. Choices: 'random'
%       - cmap - string designating colormap (e.g. 'jet' or 'hot'). Only
%       available for random style, for all others, will default to jet
%   OUTPUTS:
%       - coloredIm - m x n x 3 double representing RGB image


%Read and binarize image file
im = imread(filename);
im = im2bw(im);

%Find regions in image and ranomly fill
newIm = findRegions(im);

%Color image with given style
if strcmp(coloringStyle, 'random')
    coloredIm = fillRegions_Random(newIm, cmap);
elseif strcmp(coloringStyle, 'upward')
    coloredIm = fillRegions_Upward(newIm, cmap);
elseif strcmp(coloringStyle, 'size')
    coloredIm = fillRegions_BySize(newIm, cmap);
end

%Show colored image
figure;
imshow(coloredIm)

end

