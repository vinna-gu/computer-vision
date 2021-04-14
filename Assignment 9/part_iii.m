% Refer to the "transfer learning" link.
% In this part, you will also transfer layers, but additionally transfer 
% FC6 and FC7, all the way up to (but excluding) FC8 (i.e., transfer the 
% layers up to the one just before 'fc8'). Now append a single 
% fully-connected layer, as before. Train the network, evaluate performance 
% on the test set, and describe your observations in the answers file.
scenesLazebnik = fullfile('scenes_lazebnik');
imds = imageDatastore(scenesLazebnik, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

[imdsTrain, imdsValidation] = splitEachLabel(imds, 100 ,'randomized');

% need to install the alexnet toolbox thingy first to get this line running
net = alexnet;

% layers up to but excluding the FC6 layer (i.e., transfer the layers up to 
% the one just before 'fc6'). It will be helpful to see what layers you are 
% transfering; try the net.Layers to get a list of the layers in AlexNet. 

% view the layers
viewLayers = net.Layers(1:end)

% transfer the layers up to the one just before 'fc8'
viewLayers = net.Layers(1:22)

layers = [
    viewLayers
    fullyConnectedLayer(8)
    softmaxLayer
    classificationLayer];

% Then train and evaluate performance, and describe your observations.
% time to train the network using trainNetwork
options = trainingOptions('sgdm', ...
    'MaxEpochs', 1, ...
    'InitialLearnRate', 0.001, ...
    'Plots', 'training-progress');
trainNet = trainNetwork(imds, layers, options);

% output the performance on test set after last iteration using classify
% function and imdTest.Labels
output = classify(trainNet, imdsValidation);
acc = sum(output == imdsValidation.Labels) ./ numel(imdsValidation.Labels)
