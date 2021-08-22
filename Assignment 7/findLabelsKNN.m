function [predicted_labels_test] = findLabelsKNN(pyramids_train, labels_train, pyramids_test, k)
% pyramids_train = MxD matrix -- M = size of training image set, D =  5*K, and each pyramids(i, :) is the 1xD Spatial Pyramid Match 
% pyramids_test = NxD matrix -- N = size of test image set
% labels_train should be an Mx1 vector of training labels.
% predict_labels_test = Nx1 vector of predicted labels for test imgs
 

% DIRECTIONS:
% For each test image, compute the Euclidean distance between its descriptor 
% and each training image's descriptor (the descriptors are now the Spatial 
% Pyramids). Then find its k closest neighbors (i.e., smallest distance)
% among only training images; you can use the Matlab function pdist2. Find 
% the mode (most common value; see Matlab's function mode) among the labels, 
% and assign this label to the test image. In other words, the neighbors are 
% "voting" on the label of the test image. Do not worry about ties (mode 
% returns the smallest of the tied values which is fine for this HW)

N = size(pyramids_test, 1);
% should be N x 1 where N = size of test image set 
predicted_labels_test = zeros(N, 1);

% For each test image
for i=1:N
    % compute the euclidean distance between the descriptor
    % (pyramids_test) and the training images using pdist2
    X = pyramids_test(i, :);
    Y = pyramids_train;
    euclideanDist = pdist2(X, Y);
    % Then find its k closest neighbors
    
    
    % what we will be returning should be a Nx1 into predicted_labels_test

end


end