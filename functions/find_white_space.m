function [x,y] = find_white_space(image_matrix, startX, startY)
% Returns the first index of a white pixel

startY = 1;

% Loop through each pixel in the image
for ii = startX:size(image_matrix,1)
    for jj = startY:size(image_matrix,2)
        % Check for white pixel
        if image_matrix(ii,jj)
            %              fprintf('White found at (%d, %d)\n',ii,jj);
            x = ii;
            y = jj;
            
            [ ~,x,y ] = expand_and_mark(image_matrix,x,y);
            keyboard
            % Expand the white space out
            
            
            
            return
            
        end
    end
    fprintf('%5d of %5d\n',ii,size(image_matrix,1));
end

% If we got this far, there are no whites left
x = nan;
y = nan;
return
end

function [image_matrix_new,x_new,y_new] = expand_and_mark(image_matrix,x,y)

fprintf('Checking (%d,%d) : %d\n' ,...
    x(end),y(end),image_matrix(x(end),y(end)));
image_matrix(x(end),y(end)) = 0;

if (image_matrix(x+1,y))
    fprintf('\tExpanding\n');
    x = [x, x+1];
    y = [y, y];
    [image_matrix_new,x_new,y_new] = expand_and_mark(image_matrix,x,y);
end
return
end









