function [x,y] = find_white_space(image_matrix, startX, startY)
% Returns the first index of a white pixel

startY = 1;

% Loop through each pixel in the image
for ii = startX:size(image_matrix,1)
    for jj = startY:size(image_matrix,2)
        % Check for white pixel 
        if image_matrix(ii,jj)
            % Return the image
%              fprintf('White found at (%d, %d)\n',ii,jj);
             x = ii;
             y = jj;
             
             % Expand the white space out
             x = [ii, ii+1];
             y = [jj];
             
             
            return
            
        end
    end
    fprintf('%5d of %5d\n',ii,size(image_matrix,1));
end
    
% If we got this far, there are no whites left
x = nan;
y = nan;
return

% function check_pixel_neighbours(x,y,maxX,maxY)

