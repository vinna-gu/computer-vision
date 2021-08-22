function [bow_repr] = computeBOWRepr(features, means)
% features = Nx8 set of descriptors computed for the image
% means = kx8 set of cluster means
% bow_repr = normalized bag-of-words histogram
 
% [2 pt] A bag-of-words histogram has as many dimensions as the number of clusters k, so initialize the bow variable accordingly.
% initialize bow to zeroes and as the size of the means = k x 8 where k = 2, 5, 10, 50, 100, 200
k = size(means, 1);
finalBow = zeros(1, k);  % remember, k = clusters so the histogram is size # of clusters given in compare_representations.m

% [4 pts] Next, for each feature (i.e. each row in features), 
% compute its distance to each of the cluster means, and find the closest mean. 
featureRow = size(features, 1);  % each row corresponds to the SIFT feature
featIndex = []; % to store featureRow index
for i=1:featureRow    %for each row in features
    % we'll set a minimum at a high number for now
    min = 1000; % intialize a min (i don't think it'll go up to this after seeing pdist2 outputs)
   % we will loop through means, k value clusters
   for j=1:k
       % obtain the euclidian distance of features and means --> D = pdist2(X,Y,Distance)
       X = features(i, size(features, 2));  
       Y = means(j, size(means, 2));

       distance = pdist2(X, Y, 'euclidean'); 
  
       % determine the minimum distance
       if min > distance
%            fprintf("min: %d & dist: %d", min, distance);
           min = distance;  % set this as the new minimum bc it's the closest
%            disp(min);
           featIndex = [featIndex, j];  % save it's index
       end
   end
end

% [4 pts] To compute the bag-of-words histogram, count how many features are mapped to each cluster.
% loop through the featIndex
for m=1:featureRow
    finalBow(featIndex(m)) = finalBow(featIndex(m)) + 1;
end

% % Finally, normalize the histogram by dividing each entry by the sum of the entries. (just a simple normalization. No clipping.)
sumEntries = sum(finalBow);
finalBow = finalBow/sumEntries;
bow_repr = finalBow;
% bow_repr = 1;
end