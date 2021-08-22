% losses.m
load("weights_samples.mat");

% we have 3 sets of weights and 4 data samples
weights = {W1, W2, W3};
dataSamples = {x1, x2, x3, x4}; % x1 = class 1, x2 = class 2, etc.

% 1. hinge loss and cross-entropy loss using W1 and x1, x2, x3, x4
% % this is not working try to figure it out later
% W1Vals = [(W1 * x1); (W1 * x2); (W1 * x3); (W1 * x4)];
% sum = 0;
% for i=1:4
%    sum = sum +  hinge_loss(W1Vals(i, 1), i);
% end

% get hinge loss with W1
w1_hinge1 = hinge_loss((W1 * x1), 1);
w1_hinge2 = hinge_loss((W1 * x2), 2);
w1_hinge3 = hinge_loss((W1 * x3), 3);
w1_hinge4 = hinge_loss((W1 * x4), 4);
% get cross-entropy with W1
w1_cross1 = cross_entropy_loss((W1 * x1), 1);
w1_cross2 = cross_entropy_loss((W1 * x2), 2);
w1_cross3 = cross_entropy_loss((W1 * x3), 3);
w1_cross4 = cross_entropy_loss((W1 * x4), 4);

% 2. hinge loss and cross-entropy loss using W2 and x1, x2, x3, x4
% get hinge loss with W2
w2_hinge1 = hinge_loss((W2 * x1), 1);
w2_hinge2 = hinge_loss((W2 * x2), 2);
w2_hinge3 = hinge_loss((W2 * x3), 3);
w2_hinge4 = hinge_loss((W2 * x4), 4);
% get cross-entropy with W2
w2_cross1 = cross_entropy_loss((W2 * x1), 1);
w2_cross2 = cross_entropy_loss((W2 * x2), 2);
w2_cross3 = cross_entropy_loss((W2 * x3), 3);
w2_cross4 = cross_entropy_loss((W2 * x4), 4);

% 3. hinge loss and cross-entropy loss using W3 and x1, x2, x3, x4
% get hinge loss with W3
w3_hinge1 = hinge_loss((W3 * x1), 1);
w3_hinge2 = hinge_loss((W3 * x2), 2);
w3_hinge3 = hinge_loss((W3 * x3), 3);
w3_hinge4 = hinge_loss((W3 * x4), 4);
% get cross-entropy with W2
w3_cross1 = cross_entropy_loss((W3 * x1), 1);
w3_cross2 = cross_entropy_loss((W3 * x2), 2);
w3_cross3 = cross_entropy_loss((W3 * x3), 3);
w3_cross4 = cross_entropy_loss((W3 * x4), 4);

% compute the average of the losses of the four data samples in each case
% W1
w1_hingeAvg = (w1_hinge1 + w1_hinge2 + w1_hinge3 + w1_hinge4) / 4;
w1_crossAvg = (w1_cross1 + w1_cross2 + w1_cross3 + w1_cross4) / 4;

% W2
w2_hingeAvg = (w2_hinge1 + w2_hinge2 + w2_hinge3 + w2_hinge4) / 4;
w2_crossAvg = (w2_cross1 + w2_cross2 + w2_cross3 + w2_cross4) / 4;

% W3
w3_hingeAvg = (w3_hinge1 + w3_hinge2 + w3_hinge3 + w3_hinge4) / 4;
w3_crossAvg = (w3_cross1 + w3_cross2 + w3_cross3 + w3_cross4) / 4;

% Then we will know which of the weights are the best with respect to hinge loss and cross-entropy loss
fprintf("Weight 1\n");
fprintf("Hinge Loss = %f\n", w1_hingeAvg);
fprintf("Cross Entropy Loss = %f\n", w1_crossAvg);
fprintf("\n");

fprintf("Weight 2\n");
fprintf("Hinge Loss = %f\n", w2_hingeAvg);
fprintf("Cross Entropy Loss = %f\n", w2_crossAvg);
fprintf("\n");

fprintf("Weight 3\n");
fprintf("Hinge Loss = %f\n", w3_hingeAvg);
fprintf("Cross Entropy Loss = %f\n", w3_crossAvg);
