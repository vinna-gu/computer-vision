% compare_classifiers.m
% Apply the SVM and KNN classifiers (i.e. call findLabelsSVM, findLabelsKNN) 
% to predict labels on the test set, using the pyramid variable as the 
% representation for each image. For KNN, use the following values of 
% k=1:2:21. Each value of k gives a different KNN classifier.


% SVM classifier using findLabelsSVM to predict labels
predictedTrainTest = findLabelsSVM(pyramidTrain, train_labels, pyramidTest);


 



