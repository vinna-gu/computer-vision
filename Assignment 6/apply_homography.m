function [p2] = apply_homography(p1, H)
%  apply the homography and convert back from homogeneous coordinates,
%  as shown in slide 42 (i.e., [wx' wy' w'] to [x' y']).

% first we gotta flip it into a 3x1 like in slide 42
p1 = [ p1(1);
       p1(2);
       p1(3)];

% compute p' = H * p (regular matrix multiply)   
p2 = H * p1;   
% disp(p2);

% convert p' from homgenous to image coordinates
% p' (or p2) will actually have to output in [x', y']
% divide --> wx'/w && wy/w -- p2(3) == w
xPrime = (p2(1)/ p2(3));    % p2(1) = wx'
yPrime = (p2(2)/ p2(3));    % p2(2) = wy'

% return p2 as (x' ,y')
p2 = [xPrime, yPrime];

end