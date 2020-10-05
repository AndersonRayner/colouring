function coloredIm = fillRegions_Upward(newIm, cmap)
%Fills regions with unique grayscale values with colors in an upward fashion
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

%Get heights of each region
rows = zeros(1, numRegions);
cols = zeros(1, numRegions);
sizeRegion = zeros(1, numRegions);
for ii = 1:numRegions
    [rows_tmp, cols_tmp] = find(newIm == vals(ii));
    cols(ii) = median(cols_tmp);
    rows(ii) = median(rows_tmp);
end

[~, orderInds] = sort(rows);

%Assign random colors to each region index
colors = colormap(jet(numRegions));

%For each region, fill rgb channels with assigned random color
for ii = 1:numRegions
    color = colors(ii, :);
    inds = (newIm == vals(orderInds(ii)));
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

