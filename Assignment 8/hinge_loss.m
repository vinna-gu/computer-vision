function [loss] = hinge_loss(scores, correct_class) 
% scores = 4x1 set of predicted scores, one score for each class, for some sample, and
% correct_class = correct class for that same sample.
% loss = scalar measuring the hinge loss, as defined in class, given these scores and ground-truth class.
% slide 49 getssum of max(0, sj - sy + 1) 
% sj = other label scores && sy = correct label score
% my brainnnnnn

% first see what the correct class is, then do a loop that goes through the
% list of scores and skips the one that matches correct_class value
sum = 0;
 for i=1:size(scores, 1)
     % if we match the correct_class, we can skip
     if i == correct_class
        continue
     else
        % set the other score and correct score
        otherScore = scores(i, 1);
        correctScore = scores(correct_class, 1);
        
        % take the max --> max(0, sj - sy + 1) 
        sum = sum + max(0, (otherScore - correctScore) + 1); 
     end
end
% set the loss to sum so it'll give return value
loss = sum;
end