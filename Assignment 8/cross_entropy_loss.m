function [loss] = cross_entropy_loss(scores, correct_class)
% slide 57 -log(e(score) / sum esj)

% first, let's get the sum
sum = 0;
for i=1:size(scores, 1)
    % sum up the scores 
    sum = sum + exp((scores(i, 1)));
end

% normalize it and then take the -log of the normalization
normalize = exp(scores)/sum;
logValue = -log(normalize(correct_class));

% return the loss with the log value
loss = logValue;
% disp(loss);
end