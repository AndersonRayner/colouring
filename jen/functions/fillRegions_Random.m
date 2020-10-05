function coloredIm = fillRegions_Random(newIm, cmap)
%Fills regions with unique grayscale values with random colors
%   INPUTS:
%       - newIm - m x n grayscale image
%       - cmap - colormap (e.g. 'jet' or 'hot'). optional
%   OUTPUTS:
%       - coloredIm - m x n x 3 rgb image

%Initialize RGB chanels to be used for colored image
r= zeros(size(newIm,1), size(newIm, 2));
g = zeros(size(newIm,1), size(newIm, 2));
b = zeros(size(newIm,1), size(newIm, 2));

%Find unique values correesponding to regions
vals = unique(newIm(newIm ~= 0));  
numRegions = length(vals);

%Assign random colors to each region index
colors = zeros(numRegions, 3);
if ~isempty(cmap)
    cmap = colormap(cmap);
    n = length(cmap);
    for ii = 1:numRegions
        colors(ii, :) = cmap(randsample(n, 1), :);
    end
else
    colors = rand(numRegions, 3);
end

%For each region, fill rgb channels with assigned random color
for ii = 1:numRegions
    color = colors(ii, :);
    inds = (newIm == vals(ii));
    r(inds) = color(1);
    g(inds) = color(2);
    b(inds) = color(3); 
end

%Put channels together to complete image
coloredIm = zeros(size(newIm,1), size(newIm, 2), 3);
coloredIm(:,:,1) = r;
coloredIm(:,:,2) = g;
coloredIm(:,:,3) = b;

end

