function [idxX,idxY] = find_white_space(image_matrix, startX, startY)
% Returns the first index of a white pixel

Xpos = startX;
Ypos = startY;

idxX = [];
idxY = [];

newX = [];
newY = [];


[ Xmax, Ymax ] =  size(image_matrix);

while (Xpos <=  Xmax)
    while (Ypos <= Ymax)
        
        
        % Check to find white space
        if image_matrix(Xpos,Ypos)
            % White space found, add to the new pixel vectors
            newX(end+1) = Xpos;
            newY(end+1) = Ypos;
            
            while (~isempty(newX))
                % Pixel should be white, look around it
                Xpos = newX(1);
                Ypos = newY(1);
                
                % Add current pixel to our output indicies
                idxX(end+1) = Xpos;
                idxY(end+1) = Ypos;
                
                % Expand out the found pixel
                % Look up
                if image_matrix(Xpos,max(Ypos-1,1))
                    newX(end+1) = Xpos;
                    newY(end+1) = max(Ypos-1,1);
                    image_matrix(Xpos,max(Ypos-1,1)) = 0;
                end
                
                % Look left
                if image_matrix(max(Xpos-1,1),Ypos)
                    newX(end+1) = max(Xpos-1,1);
                    newY(end+1) = Ypos;
                    image_matrix(max(Xpos-1,1),Ypos) = 0;
                end
                
                % Look right
                if image_matrix(min(Xpos+1,Xmax),Ypos)
                    newX(end+1) = min(Xpos+1,Xmax);
                    newY(end+1) = Ypos;
                    image_matrix(min(Xpos+1,Xmax),Ypos) = 0;
                end
                
                % Look down
                if image_matrix(Xpos,min(Ypos+1,Ymax))
                    newX(end+1) = Xpos;
                    newY(end+1) = min(Ypos+1,Ymax);
                    image_matrix(Xpos,min(Ypos+1,Ymax)) = 0;
                end
                
                
                
                % Mark pixel as indexed
                image_matrix(Xpos,Ypos) = 0;
                
                % Remove from the new vectors
                newX = newX(2:end);
                newY = newY(2:end);
            end
            
            % This part is done, return
            return
        end
        
        % Increment Y Counter
        Ypos = Ypos + 1;
    end
    
    % Increment X Counter
    Xpos = Xpos + 1;
    Ypos = 1;
    
end

return
end

