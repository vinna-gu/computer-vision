function [predicted_labels_test] = findLabelsSVM(pyramids_train, labels_train, pyramids_test)
% pyramids_train = MxD matrix -- M = size of training image set, D =  5*K, and each pyramids(i, :) is the 1xD Spatial Pyramid Match 
% pyramids_test = NxD matrix -- N = size of test image set
% labels_train should be an Mx1 vector of training labels.
% predict_labels_test = Nx1 vector of predicted labels for test imgs

% to train a model
X = pyramids_train;     % X = features = pyramids_train
Y = labels_train;       % Y = labels we want to predict
% disp(size(X));
% disp(size(Y));
model = fitcecoc(X, Y);

% using model we learned, use label = predict(model, X_test) where X_test =
% size NxD
X_test = pyramids_test; 
label = predict(model, X_test);

% pass label into the predicted_labels_test
predicted_labels_test = label;
end