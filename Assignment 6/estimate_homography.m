function [H] = estimate_homography(PA, PB)
% Purpose: To Compute homography between points in image PA & image PB
% PA = 4x2 matrix (contains (x,y) matching points)
% PB = 4x2 matrix (first row of PB and PA should be matching)
% Output of H = 3x3 matrix

% Set up A -- Slide 36  2 x 9 matrix shown below?
% [ -x, -y, -1, 0, 0, 0, xx', yx' , x';
%  0, 0,  0, -x, -y, -1, xy', yy', y'] 

% A will have to be a 8 x 9 matrix due to the points in PA/PB and also due
% to the fact that A is a 2x9 matrix already itself
A = zeros( (2 * size(PA, 1)) , 9);

% we're going to loop through the points matrix
for i=1:1:size(PA, 1)
    % to make easier to read, get values where x & y = PA and x' & y' = PB
    x = PA(i);
    y = PA(i, 2);
    xPrime = PB(i);
    yPrime = PB(i, 2);
    
    % 1st row of A --> -x, -y, -1, 0, 0, 0, xx', yx' , x'
    A(((i * 2) - 1), :) = [ -x, -y, -1, 0, 0, 0, (x * xPrime), (y * xPrime), xPrime];
    % 2nd row of A -->  0, 0,  0, -x, -y, -1, xy', yy', y'
    A((i * 2), :) = [0, 0,  0, -x, -y, -1, (x * yPrime), (y * yPrime), yPrime];
end

% disp(A(:, :));
% Now solve for H using: 
[~, ~, V] = svd(A); 
h = V(:, end); 
H = reshape(h, 3, 3)';

end