% 10. [3 pts] Create a function function [val] = fib(n) that returns the n-th number 
% (n >= 1) in the Fibonacci sequence 1, 1, 2, 3, 5, 8, 13...
function [val] = fib(n)
% if n is <= 1, the only choices would be 0 or 1
if n <= 1
    val = n;
else 
    val = fib(n - 1) + fib(n - 2); % the number before n and add the number before that to get next number
end
end