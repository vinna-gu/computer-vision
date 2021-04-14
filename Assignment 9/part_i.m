% Refer to the "train network" link for details on how to set up the data:
% https://www.mathworks.com/help/deeplearning/ref/trainnetwork.html
% Unelss otherwise specified, use a learning rate of 0., a maximum of 1
% epochs, 100 images per class for training, and rest (50) for testing
% accessing the folder scenes_lazebnik
scenesLazebnik = fullfile('scenes_lazebnik');
imds = imageDatastore(scenesLazebnik, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

[imdsTrainSet, imdsValidation] = splitEachLabel(imds, 100, 'randomized');

% Create network w/ 3 groups of layers (A, B, C)
layers = [ ...
    % set the images at size 227x227x3
    imageInputLayer([227, 227, 3]) 
    
    % ~~~handling A, B, C part~~~
    % A = 50 11x11 layers w/ stride 4, RELU, max pool 3x3 stride 1
    convolution2dLayer(11, 50)
    reluLayer
    maxPooling2dLayer(3,'Stride',1)
    
    % B = 60 5x5 layers w/ stride 4, RELU, max pool 3x3 stride 2
    convolution2dLayer(5, 60)
    reluLayer
    maxPooling2dLayer(3,'Stride',2)
    
    % C = fully-connected layer size 8 (for 8 classes), softmax & classification layer
    fullyConnectedLayer(8)
    softmaxLayer
    classificationLayer];

% Use the "training options" link and specify:
% 1) Max number of epochs = 1 as stated in hw
% 2) Learning rate = 0.001 as stated in hw
% 3) set Plots variable to show training progress
options = trainingOptions('sgdm', ...
    'MaxEpochs', 1, ...
    'InitialLearnRate', 0.001, ...
    'Plots', 'training-progress');

% time to train the network using trainNetwork
trainNet = trainNetwork(imds, layers, options);

% output the performance on test set after last iteration using classify
% function and imdTest.Labels
output = classify(trainNet, imdsValidation);
acc = sum(output == imdsValidation.Labels) ./ numel(imdsValidation.Labels)
