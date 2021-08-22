function [Output] = my_pool(Input, Pool_Size)
% Idea: computes the output of max-pooling over Pool_Size x Pool_Size regions of the input
% Input = square matrix assume to be result from applying RELU on output from convolution.
% Pool_Size = scalar saying over what size of regions to compute max (e.g. use 2 for pooling over 2x2 regions).
% Output = single-channel matrix resulting from the max-pooling

% slide 110
[height, width] = size(Input);

tempMatrix = [];
for i=1:Pool_Size:height
   for j=1:Pool_Size:width 
       % almost similar to my_conv but we want the MAXIMUM value
       block = Input(i : (i + Pool_Size - 1), j : (j + Pool_Size - 1));
       
       % take the max values of that block
       maxValues = max(block);
       % take the maxValue of the maxValue
       maxValue = max(maxValues);
       tempMatrix = [tempMatrix, maxValue];
   end
end
% disp(size(tempMatrix)); % need to check to see why i keep running into an error
% disp(tempMatrix);

% reshape it if it has more than 1 value?
if (size(tempMatrix, 2) > 1)
    poolArr = zeros(Pool_Size, Pool_Size);
    % disp(poolArr);
    tempMatrix = reshape(tempMatrix, [size(poolArr, 1), size(poolArr, 2)]);
    Output = tempMatrix.';
else
    Output = tempMatrix.';
end
% disp(Output);
end