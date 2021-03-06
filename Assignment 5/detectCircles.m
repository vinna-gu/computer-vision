function [centers] = detectCircles(im, edges, radius, top_k)
% im = RGB input image of class uint8
% edges = Nx4 matrix containing 4 numbers for each N detected edge points
% radius = size of circle we're looking for
% top_k = how many of the top-scoring circle center possibilities to show
% centers = Nx2 matrix which each row lists x,y position center
% NOTE TO SELF: refer to slide 53 of vision_04.pptx
% First, initialize accumulator H to all zeros
H = zeros(size(im, 1), size(im, 2));
quantVal = 5;

% NOTE: edges outputs: x_inds(1), y_inds(2), edge_mag(3), edge_orient(4)
% for each edge point (x, y) in the image
for i=1:size(edges, 1)
  
    % θ = the degree in edge_orient
    a = edges(i, 1) - (radius * (cosd(edges(i, 4)))); % radius and degrees are given
    b = edges(i, 2) - (radius * (sind(edges(i, 4))));
    
    % to ignore the negative values that are being outputted from a and b
    if (a > 0) && (b > 0)
        % then we can get the hough space using ceil(a/quantization_value)
        a = ceil(a / quantVal);
        b = ceil(b / quantVal);
        
        % store it into accumulator
        H(a, b) = H(a, b) + 1;
    end
    
end
% disp(H);
% sort the H array where the highest number is at the top of the column
[someNum, indices] = sort(H(:), 1,'descend');
[row, col] = ind2sub(size(H), indices(1:top_k)); % get the index by arranging them in an mxn array given by size(H)
% disp([row, col])
% need to multiply by quantVal to find out actual x, y location
centers = [(row * quantVal), (col * quantVal)]
figure;
imshow(im);
viscircles(centers, radius * ones(size(centers, 1), 1));
title(['circle radius: ' num2str(radius) ' with top ' num2str(top_k) ' points']);
end