 function [pyramid, level_0, level_1] = computeSPMRepr(im_size, sift, means) 
% http://pitt.edu/~sjh95/cs1674_s21/hw7/hw7.html
% imsize = image size [height, width]
% sift = SIFT features --> .d returns SIFT features?, .f returns locations
% means = cluster centers from bag of visual words
% pyramid = 1xD feature descriptor
% level_0 = BOW histogram
% level_1 = BOW histogram at level-1

% storing the height and width of the image (passed in as [height, width])
height = im_size(1,1);
width = im_size(1,2);

% .d = sift features & .f = sift locations
features = sift.d;
location = sift.f;

% 1st, create BOW for level_0
level_0 = computeBOWRepr(features', means);

% divide img into 4 quads -- make 4 BOW histograms using computeBOWRepr
quad1 = [];
quad2 = [];
quad3 = [];
quad4 = []; 

% for each column (features, 2)--- row = (features, 1)
for i=1:size(features, 2)
    % obtain the x and y values from the sift location (f variable of SIFT)
    x = location(1, i);
    y = location(2, i);
    
    centerHeight = (height / 2);    % this will help determine where the center x line starts
    centerWidth = (width / 2);      % this will help determine where the center y line starts
    
    % Quadrant 1 -- top right -- y is right of centerWidth and x is < center height 
    if(y > centerWidth && x < centerHeight) 
        quad1 = [quad1, features(:, i)];
    % Quadrant 2 -- top left -- y is left of centerWidth and x is < center height 
    elseif (y < centerWidth && x < centerHeight) 
        quad2 = [quad2, features(:, i)];
    % Quadrant 3 -- bottom left -- y is left of centerWidth and x is > center height 
    elseif (y < centerWidth && x  > centerHeight) 
        quad3 = [quad3, features(:, i)];
    % Quadrant 4 -- bottom right -- y is right of centerWidth and x is > center height 
    elseif (y > centerWidth && x > centerHeight) 
        quad4 = [quad4, features(:, i)];
    end
end

% same situation as the level_0, just storing it in []
level_1 = [computeBOWRepr(quad1', means), computeBOWRepr(quad2', means), computeBOWRepr(quad3', means), computeBOWRepr(quad4', means)];

% level_0 and level_1 should be stored in the pyramid variable
pyramid = [level_0, level_1];
end