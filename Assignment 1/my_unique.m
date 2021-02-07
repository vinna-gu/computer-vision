% 11. [3 pts] Implement a function function [N] = my_unique(M) that takes in a matrix M, 
% removes duplicate rows from that input matrix and outputs the result as matrix N. 
% You cannot call Matlab's unique function. Loops are allowed.
function [N] = my_unique(M)
tempM = zeros(size(M));     % generating a matrix that contains only 0's for now

% looping through the matrix starting with rows (i) and then columns (j)
for i = 1:size(M, 1)
    % if there isn't a match with tempM and M
    if ismember(tempM, M(i,:), 'rows') == 0
        % store it into tempM
        tempM(i, :) = M(i, :)
        continue;
    else
        % delete a row from tempM if it is a member
        tempM(ismember(tempM, M(i,:) == 1, 'rows'), :) = [];
    end 
end
N = tempM;
end