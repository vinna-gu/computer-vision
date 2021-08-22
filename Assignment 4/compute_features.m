% my OG compute_features
function [features] = compute_features(x, y, scores, Ix, Iy)
% (x, y) = detected keypoint
% scores = score at the keypoint
% Ix = Ih = imfilter(grayScaleIm, double(horiz)); = the dimensions of img
% Iy = Iv = imfilter(grayScaleIm, double(vert)); = the dimensions of img

% first, keypoints need to have 5 or more neighbors by looping through the
% list of x,y coordinates
colSize = size(Ix, 1); % 200 pixel height
rowSize = size(Ix, 2); % 275 pixel width
totalScores = size(scores, 1);

% storing the indices we want to remove in this array
indicesToRemove = [];
% loop through the list (x, y, or scores doesn't matter, they're same size)
for i=1:totalScores
    % check to make sure it has 5 neighbors (chose 6 because the point
    % should be centered, with 5 neighbors top/bottom/left/right of it)
    if x(i) < 6
        indicesToRemove = [indicesToRemove, i];
    end
    if (x(i) >= (rowSize - 5))  % if it's greater than the dimension - 5
        indicesToRemove = [indicesToRemove, i];
    end
    if (y(i) < 6)
        indicesToRemove = [indicesToRemove, i];
    end
    if (y(i) >= (colSize - 5))
        indicesToRemove = [indicesToRemove, i];
    end
end
% removing them all together at once 
x(indicesToRemove) = [];
y(indicesToRemove) = [];
scores(indicesToRemove) = [];

m = zeros(colSize, rowSize);        % gradient magnitude m(x, y)
theta = zeros(colSize, rowSize);    % gradient angle θ(x, y)

% [8 pts] To compute the gradient magnitude m(x, y) and gradient angle θ
% (x, y) at point (x, y)
% disp(m(1, 1));
for i=1:colSize
    for j=1:rowSize
        
        % needed to convert to double because sqrt can't handle uint8 vals
        val1 = (double((Ix(i, j))^2));
        val2 = (double((Iy(i, j))^2));
        
        % first, if both values are 0, it's pointless to sqrt(0)
        if (val1 == 0) && (val2 == 0)
            continue;
        else
            % otherwise, sqrt
            m(i, j) = sqrt(val1 + val2);

            % if gradient magnitude ends up outputting a 0, then both are 0
            if m(i, j) == 0
               theta(i, j) = 0;
               continue; % continue to the next j
            else
               theta(i, j) = atand((double(Iy(i, j))) / (double(Ix(i, j)))); 
            end
        end
        
    end
end


% quantization matrix with same size as image
orientationBin = zeros(colSize, rowSize);
% % loop through, determine if pixel at position (x,y) belongs in bin 1-8
for i=1:colSize
    for j=1:rowSize
       % putting values between -90 & -67.5 in one bin, -67.4 to -45 in another, etc. (22.5 difference between those)  
       if (theta(i, j) < -67.5 && theta(i, j) >= -90) 
           orientationBin(i, j) = 1;    % store into bin with this value
       elseif (theta(i, j) < -45 && theta(i, j) >= -67.5) 
           orientationBin(i, j) = 2;
       elseif (theta(i, j) < -22.5 && theta(i, j) >= -45)
           orientationBin(i, j) = 3;
       elseif (theta(i,j) < 0 && theta(i,j) >= -22.5)
           orientationBin(i, j) = 4;
       elseif (theta(i,j) < 22.5 && theta(i,j) >= 0)
           orientationBin(i, j) = 5;
       elseif (theta(i,j) < 45 && theta(i,j) >= 22.5)
           orientationBin(i, j) = 6;
       elseif (theta(i,j) < 67.5 && theta(i,j) >= 45)
           orientationBin(i, j) = 7;
       elseif (theta(i,j) <= 90 && theta(i,j) >= 67.5)
           orientationBin(i, j) = 8;
       end
    end
end
% disp(orientationBin);

% Computing the SIFT histogram
% initializing a histogram that'll loop through the keypoints, & give hist
SIFThist = zeros(size(scores, 1), 8);
% looping through scores or x or y (as they will be the same size) where i will hold a row of SIFThist containing 8 bins
for i=1:size(scores, 1)
    % flippity
    cols = x(i);
    rows = y(i);
    % fprintf("%d, %d\n", rows, cols);
    % observe the 11x11 grid (-5/+5) & sum
    for j=(cols - 5): (cols + 5)
        for k=(rows - 5):(rows + 5)
            % fprintf("cols: %d & rows: %d\n", cols, rows);
            % get the bin number from the orientation bin
            binNum = orientationBin(j, k);
                
            % depending on what binNum is, store it in the hist & add all values that have the same bin num
            switch binNum
                case 1
                    SIFThist(i, 1) = SIFThist(i, 1) + m(j, k);   % add it to the hist i @ position/bin 1
                case 2
                    SIFThist(i, 2) = SIFThist(i, 2) + m(j, k);
                case 3
                    SIFThist(i, 3) = SIFThist(i, 3) + m(j, k);
                case 4
                    SIFThist(i, 4) = SIFThist(i, 4) + m(j, k);
                case 5
                    SIFThist(i, 5) = SIFThist(i, 5) + m(j, k);
                case 6
                    SIFThist(i, 6) = SIFThist(i, 6) + m(j, k);
                case 7
                    SIFThist(i, 7) = SIFThist(i, 7) + m(j, k);
                case 8
                    SIFThist(i, 8) = SIFThist(i, 8) + m(j, k);
             end
        end
    end
    
end

% [6 pts] Finally, you should clip all values to 0.2 as discussed in class, 
% and normalize each descriptor to be of unit length, e.g. using hist_final = hist_final / sum(hist_final); 
% Normalize both before and after the clipping (i.e., 1. normalize, 2. clip, 3. normalize again).
hist_final = [];
for i=1:size(SIFThist, 1)
    % set hist_final = to the index with the 8 bins = 1:size(SIFThist, 2)
    hist_final(i, 1:size(SIFThist, 2))= SIFThist(i, 1:size(SIFThist,2))/(sum(SIFThist));
end

% clip the values by looping through the sifthist list
for i=1:size(SIFThist, 1)
    % loop through the bins to view what values are inputted into SIFThist
    for countBin=1:size(SIFThist, 2)
        % if the number is higher than the threshold of 0.2, set it to 0.2
        if hist_final(i, countBin) >= 0.2
            hist_final(i, countBin) = 0.2;
        end
    end
end

% normalizing 2nd time around
for i=1:size(SIFThist, 1)
    % set hist_final = to the index with the 8 bins
    hist_final(i, 1:size(SIFThist, 2))= SIFThist(i, 1:size(SIFThist,2))/(sum(SIFThist));
end

% remove this hist_final placeholder;
features = hist_final;
end