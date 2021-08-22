% First, encode all inputs and weights as matrices/vectors in Matlab. In our example, D=4, M=3, K=2.
x = [10, 1, 2, 3];
w1 = [0.5, 0.6, 0.4, 0.3;
      0.02, 0.25, 0.4, 0.3;
      0.82, 0.1, 0.35, 0.3];   % these are the weights of the FIRST layer
w2 = [0.7, 0.45, 0.5;
      0.17, 0.9, 0.8];         % these are the weights of the SECOND layer

% compute and print the value of z2
% we'll loop through the weights/inputs, and sum it
z2 = 0;
for i=1:size(x, 2)
   z2 = z2 + (w1(2, i) * x(1, i));  % add it to z2 every time
end

z2 = tanh(z2);
% print in command line
fprintf("z2 = %f\n", z2);

% compute and print the value of y1. 
% RELU activation is used at the hidden layer --> max(0,x)
% first we need to get all the z values and store them into an array
zi = [0, 0, 0];
for i=1:3   % that's the number of rows in w1
   for j=1:size(x,2)
       zi(1, i) = zi(1, i) + (w1(i, j) * x(1, j));
   end
end

% take the max of each one (RELU)
for i=1:size(zi, 2)
    zi(1, i) = max(0, zi(1, i));
end

% implement sigmoid activation --> 1/(1+exp(-x))
sum = 0;
% loop through to get the sum
for i=1:size(zi, 2)
   sum = sum + (zi(1, i) * w2(1, i)); 
end
y1 = 1/(1 + exp( -(sum))); 
fprintf("y1 = %f\n", y1);
