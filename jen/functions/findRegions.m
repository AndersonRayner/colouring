function newIm = findRegions(im)
%Finds each enclosed space in a binarized image and fills it with a random
%shade
%   INPUTS:
%       - im - m x n binary image
%   OUTPUTS:
%       - newIm - m x n matrix with reach region filled with a random
%       grayscale value

%Initialize newIm as a black and white duplicate of the original
newIm = double(im);

%Loop through each pixel
for ii = 2:size(im, 1)-1
    for jj = 2:size(im, 2)-1
        
        %Determine if current pixel is unfilled
        if newIm(ii, jj) == 1
            
            %Get 3x3 array of pixels with current pixel at center
            subNewIm = newIm(ii-1:ii+1, jj-1:jj+1);
            
            %If any pixel in the 3x3 array are already colored, use that
            %color. Otherwise, asign a new random value
            r_vals = subNewIm(subNewIm~= 0 & subNewIm ~= 1);
            if ~isempty(r_vals)
                color = r_vals(1);
            else
                color = rand;
            end
            
            %Handle the case where there was more than one color found in
            %the 3x3 window. In that case, fill all of the extra colors
            %with the chosen value so that the region is all the same color
            r_vals = unique(r_vals(r_vals ~= color));
            if ~isempty(r_vals)
                for cc = 1:length(r_vals)
                    newIm(newIm == r_vals(cc)) = color;
                end
            end
            
            %Color the appropriate pixels with the new value
            subNewIm(subNewIm ~= 0) = color;
            newIm(ii-1:ii+1, jj-1:jj+1) = subNewIm;
        end
    end
end

end

