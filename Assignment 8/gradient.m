% In this part, you will compute the numerical gradient for the first weight 
% vector from the previous part, and a weight update.
% refer to slide 65 for a general idea-ish

% lets first load the weight samples
load("weights_samples.mat");

% set h value
h = 0.0001;

% making W1 into a vector
W = W1(:);
X = [x1, x2, x3, x4];

% initializing an "old" loss -- slide 62
w1_hinge1 = hinge_loss((W1 * x1), 1);
w1_hinge2 = hinge_loss((W1 * x2), 2);
w1_hinge3 = hinge_loss((W1 * x3), 3);
w1_hinge4 = hinge_loss((W1 * x4), 4);
oldWLoss = (w1_hinge1 + w1_hinge2 + w1_hinge3 + w1_hinge4) / 4;
% we want to store it ina  "gradient dW matrix"
gradientdW = zeros(size(W1(:)));

% loop over the dimensions of weight vector
for i=1:size(W, 1)
    % add h to whatever position i is currently at (like in slide 62)
    W(i, 1) = W(i, 1) + h;
    reshapeWh = reshape(W, [4, 25]);

    % obtain a newWLoss
    w_hinge1 = hinge_loss((reshapeWh * x1), 1);
    w_hinge2 = hinge_loss((reshapeWh * x2), 2);
    w_hinge3 = hinge_loss((reshapeWh * x3), 3);
    w_hinge4 = hinge_loss((reshapeWh * x4), 4);
    newWLoss = (w_hinge1 + w_hinge2 + w_hinge3 + w_hinge4) / 4;
    
    % derivative -- subtract new one from old one and divide by h
    d = (newWLoss - oldWLoss)/h;
    gradientdW(i, 1) = d;
    % making sure to reset the weight vector to that original each time
    W = W1(:);
end

% display resulting vector as gradient
fprintf("h = 0.0001\n");
disp(reshape(gradientdW, [4, 25]));

% [2 pts] In the same script, also compute a weight update (one iteration) with learning rate of 0.001.
% set h value
h = 0.001;

% making W1 into a vector
W = W1(:);
X = [x1, x2, x3, x4];

% initializing an "old" loss -- slide 62
w1_hinge1 = hinge_loss((W1 * x1), 1);
w1_hinge2 = hinge_loss((W1 * x2), 2);
w1_hinge3 = hinge_loss((W1 * x3), 3);
w1_hinge4 = hinge_loss((W1 * x4), 4);
oldWLoss = (w1_hinge1 + w1_hinge2 + w1_hinge3 + w1_hinge4) / 4;
% we want to store it ina  "gradient dW matrix"
gradientdW = zeros(size(W1(:)));

% loop over the dimensions of weight vector
for i=1:size(W, 1)
    % add h to whatever position i is currently at (like in slide 62)
    W(i, 1) = W(i, 1) + h;
    reshapeWh = reshape(W, [4, 25]);

    % obtain a newWLoss
    w_hinge1 = hinge_loss((reshapeWh * x1), 1);
    w_hinge2 = hinge_loss((reshapeWh * x2), 2);
    w_hinge3 = hinge_loss((reshapeWh * x3), 3);
    w_hinge4 = hinge_loss((reshapeWh * x4), 4);
    newWLoss = (w_hinge1 + w_hinge2 + w_hinge3 + w_hinge4) / 4;
    
    % derivative -- subtract new one from old one and divide by h
    d = (newWLoss - oldWLoss)/h;
    gradientdW(i, 1) = d;
    % making sure to reset the weight vector to that original each time
    W = W1(:);
end

% display resulting vector as gradient
fprintf("h = 0.001\n");
disp(reshape(gradientdW, [4, 25]));