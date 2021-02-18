function [x, y, scores, Ih, Iv] = extract_keypoints(image);
    
    % setting k constant for that equation to 0.05 and window size to 5
    k = 0.05; 
    window = 5; 
    
    % reading the image and convert to double grayscale
    readImg = imread(image);
    grayScaleIm = im2double(rgb2gray(readImg));
    
    % Compute the horizontal image gradient Ih and the vertical image gradient Iv
    horiz= [1, 0, -1;
            2, 0, -2;
            1, 0, -1];
    vert = [1, 2, 1;
            0, 0, 0;
            -1, -2, -1];
    Ih = imfilter(grayScaleIm, double(horiz));   % applies the gradient filter 
    Iv = imfilter(grayScaleIm, double(vert));
   
    % initialize a matrix R of the same size as the image that will store the "cornerness" scores for each pixel
    % when R is almost 0 = flat, R << 0 = edge, R >> 0 = corner
    R = zeros(size(grayScaleIm, 1), size(grayScaleIm, 2));  % 1 = rows(x), 2 = cols(y)
    
    % use a double loop to compute cornerness score - slide 36 pseudo
    row = size(grayScaleIm, 1); 
    col = size(grayScaleIm, 2);
    for i=1:row
        for j=1:col
            
            % initializing a 2x2 matrix M for the score for now, and we're
            % at start position (1,1) for candidate keypoint (i, j)
            M = zeros(2, 2);
            
            for x=(i-1):(i+1)
                for y=(j-1):(j+1)
                    
                    % we want to ignore those edge pixels
                    if (x <= 0) || (x > row) || (y <= 0) || (y > col)
                        R(i, j) = -Inf;
                    else
                        M(1,1) = M(1,1) + (Ih(x,y)^2); 
                        M(1,2) = M(1,2) + (Ih(x,y) * Iv(x,y));
                        M(2,1) = M(2,1) + (Ih(x,y) * Iv(x,y));
                        M(2,2) = M(2,2) + (Iv(x,y)^2);
                        
                        % making sure we don't hit an -Inf
                        if R(i, j) ~= -Inf
                            R(i, j) = det(M) - k * trace(M)^2;
                        end 
                    end
                    
                end
            end
               
        end
    end
    
    % After computing all R(i, j) scores, it is time to threshold them in order to find which pixels correspond to keypoints.
    % You can set the threshold for the "cornerness" score R however you like; for example, you can set it to 5 times the average R score.
    % to ignore the -Inf part for threshold, we'll just set them to 0 for now
    for i=1:row
        for j=1:col
           if R(i, j) == -Inf
               R(i, j) = 0;
           end
        end
    end
    
    avgRScore = mean(R, 2);       % get the total average (if i kept inf, avgRScore = -Inf)
    threshold = avgRScore * .001;
    threshold = sum(threshold)/row;
    
    % if the values in R is less than the threshold, we want to ignore them
    for i=1:row
        for j=1:col
           if R(i, j) < threshold
               R(i, j) = 0;
           end
        end
    end
    
    % Perform non-maximum suppression by removing those keypoints whose R score is not larger than all of their 8 neighbors; 
    % if a keypoint does not have 8 neighbors, remove it. The scores/x/y that you output should correspond to the final set of keypoints, 
    % after non-max suppression. then set the keypoint scores and coordinates at those indices to [].
  
    % Initialize vectors for x, y, and scores
    x = [];
    y = [];
    scores = [];
    
    for i=1:row
        for j=1:col
            
            % initializing R(i, j) as max (this is a potential keypoint)
            maxX = i;
            maxY = j;
            
            for s=(i-1):(i+1)
                for t=(j-1):(j+1)
                    % we want to ignore those edge pixels
                    if (s <= 0) || (s > row) || (t <= 0) || (t > col)
                        continue;
                    else
                        % if the neighbor is greater than key, and the
                        % neighbor is greater than the max found
                        if (R(s, t) > R(i, j)) && ( R(s, t) > R(maxX, maxY))
                            % reset max
                            maxX = s;
                            maxY = t;
                        
                        % if neighbor is smaller than key, and neighbor
                        % isn't max, set it's position to 0 to ignore it
                        elseif (R(s, t) < R(i, j)) && (R(s, t) < R(maxX, maxY))
                            R(s, t) = 0;
                            
                        % if we reached the end of the neighborhood (3, 3)
                        elseif (s == (i+1)) && (t == (j+1) && (R(maxX, maxY) > 0))
                            % set the max values into indices
                            x = [x, maxY];
                            y = [y, maxX];
                            scores = [scores, R(maxX, maxY)];
                        end
                    end
                    
                end
            end

        end
    end
%     disp(scores.');
    figure;
    imshow(image);
    
    % place the points
    hold on;
    for i=1:length(scores)
        plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) * .05);
    end
    hold off;
end