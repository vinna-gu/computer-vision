% In script compare_representations.m: using SVM, compare various 
% SPM representations (pyramid, level_0 and level_1).
% train_images (matrix of size Mx2 where M is the total number of training images; it contains the height and width for each training image, which you need for the spatial pyramid representation),
% train_sift (a cell array of size Mx1, where each cell entry contains the values and locations of the SIFT descriptors for the training images; remember that we index cell array entries as {i} not (i)),
% train_labels (vector of size Mx1, containing the labels for each training image),
% test_images (matrix of size Nx2, where N is the total number of test images),
% test_sift (cell array of size Nx1),
% test_labels (vector of size Nx1).

% function [pyramid, level_0, level_1] = computeSPMRepr(im_size, sift, means)
% computing spatial pyramid match rep for the train images 
% NOTE: for some reason it won't let me do size of the train images so i
% need to explicitly hardcode the train image size
for i = 1:800
    % need to pass in the sizes of the image, and sift(features/locations)
    height = train_images(i, 1);
    width = train_images(i, 2);
    size = [height, width];
    sift = train_sift{i};   % features & locations stored here
    
    % pass it into the computeSPMRepr, and get the pyramid, level0 and level1 of train
    [pyramidTrain, level0Train, level1Train] = computeSPMRepr(size, sift, means);
end

% similar situation as trains
for i=1:400
    height = test_images(i, 1);
    width = test_images(i, 2);
    size = [height, width];
    sift = test_sift{i};
    
    [pyramidTest, level0Test, level1Test] = computeSPMRepr(size, sift, means); % all train images
end


% [5 pts] Use an SVM classifier. Compare the quality of three representations
% , pyramid, level_0 and level_1. In other words, compare the full SPM 
% representation to its constituent parts, which are the level-0 histogram 
% and the concatenations of four histograms in level-1. 

% Use SVM Classifier to compare pyramid, level0, level1
predictedLabelsTest = findLabelsSVM(pyramidTrain, train_labels, pyramidTest)
