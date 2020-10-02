function [idxX,idxY] = find_white_space(image_matrix, startX, startY)
% Returns the first index of a white pixel

Xpos = startX;
Ypos = startY;

idxX = [];
idxY = [];


[ Xmax, Ymax ] =  size(image_matrix);


while (Xpos <=  Xmax)
    while (Ypos <= Ymax)
        
       
        % Check to find white space
        fprintf('(%5d,%5d) : %d\n',Xpos,Ypos,image_matrix(Xpos,Ypos));
        if image_matrix(Xpos,Ypos)
            fprintf('\tWhite found at (%5d,%5d)\n',Xpos,Ypos);
            idxX(end+1) = Xpos;
            idxY(end+1) = Ypos;
        end
        
        % Increment Y Counter
        Ypos = Ypos + 1;
    end
    
    % Increment X Counter
    Xpos = Xpos + 1;
    Ypos = 1;
    
end

return
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









