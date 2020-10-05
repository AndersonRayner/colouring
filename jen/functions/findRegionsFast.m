%% BUGGY DOESN'T CURRENTLY WORK ON ALL IMAGES! BUT USES TOOLBOX


function newIm = findRegionsFast(im)
%Finds each enclosed space in a binarized image and fills it with a random
%shade
%   INPUTS:
%       - im - m x n binary image
%   OUTPUTS:
%       - newIm - m x n matrix with reach region filled with a random
%       grayscale value

%Initialize newIm as a black and white duplicate of the original
newIm = double(im);

%Fill each region with a random value
regions = regionprops(im, 'PixelList');
for ii = 1:length(regions)
    for jj = 1:length(regions(ii).PixelList)
        newIm(regions(ii).PixelList(jj, 2),regions(ii).PixelList(jj, 1)) = rand;
    end
end


end

