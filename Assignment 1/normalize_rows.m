% 8. [3 pts] Write a function function [B] = normalize_rows(A) which uses a single command (one line and no loops) to make the sum in each row of the matrix 1. 
% Use the repmat function. The sum of the entries in each row should be 1, in the matrix output by your function. 
% Note that you can't obliterate the original matrix, i.e. you can't just create rows with N values of 1/N each-- you have to transform the original values but preserve their order.
function [B] = normalize_rows(A)
B = A./repmat(sum(A, 2), 1, 1); 
% disp(sum(B,2));
end
 