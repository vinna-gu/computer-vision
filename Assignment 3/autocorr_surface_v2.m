function [E] = autocorr_surface(im, r, c, max_offset)

    if(nargin < 1)
        im = [ones(5, 15); [ones(10, 6) zeros(10, 9)]];
    end
%     figure; imshow(im)
    if(nargin < 3)
        impixelinfo
        c = input('c=? (first value from pixel info output) ');
        r = input('r=? (second value from pixel info output) ');
    end
    
    % to define what x, y range over
    num_neighbors_away = 1;  
    
    % to define what u, v range over
    if(nargin < 4)
        max_offset = 3;    
    end
        
    % initialize autocorrelation surface
    E = zeros(max_offset*2+1, max_offset*2+1); 
    
    for u = -max_offset:max_offset
        for v = -max_offset:max_offset
                
            % using loops
            
            S = 0;
            
            for x = r-num_neighbors_away:r+num_neighbors_away
                for y = c-num_neighbors_away:c+num_neighbors_away
                    
                    S = S + power(im(x, y) - im(x+u, y+v), 2);
                    
                end
            end
            
            % without loops
            
            A = im(r-num_neighbors_away:r+num_neighbors_away, c-num_neighbors_away:c+num_neighbors_away);
            B = im(r-num_neighbors_away+u:r+num_neighbors_away+u, c-num_neighbors_away+v:c+num_neighbors_away+v);
            
            S2 = sum(sum(power(A - B, 2)));
%             assert(all(S(:) == S2(:)));
            
            % save as error surface entry
            
            E(max_offset+1+u, max_offset+1+v) = S;
            
        end
    end
    
    % plot autocorrelation surface
%     figure; 
%     imshow(E);
    