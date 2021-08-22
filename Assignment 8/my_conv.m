function [Output] = my_conv(Image, Filter, Padding, Stride)
% Image = grayscale single-channel image
% Filter = single-channel filter
% Padding = scalar saying how much padding to apply above/below and to the left/right of the Image.
% Stride = scalar saying what stride to use to advance over the Image during convolution. -- it's what you skip
% Output = single-channel matrix resulting from the convolution operation.

% output2a = my_conv(Image, Filter, 1, 4); && output1a = my_conv(Image, Filter, 0, 2);
% slide 137
% get the image size
[Nh, Nw] = size(Image); 
[Fh, Fw] = size(Filter);

% generate a padding using: (N + 2*padding - F) / stride + 1
% where N = Nh or Nw && F = Fh or Fw
paddingH = (Nh + (2 * Padding) - Fh) / Stride + 1;
paddingW = (Nw + (2 * Padding) - Fw) / Stride + 1;


% set a new image with that padding
newImage = zeros((Nh + (2 * Padding)), (Nw + (2 * Padding)));
newImage = zeros(size(Image,1)+2*Padding, size(Image,2)+2*Padding);

% put the image on the new padded image
newImage((1 + Padding) : (Nh + Padding), (1 + Padding) : (Nw + Padding) ) = Image;
[newH, newW] = size(newImage);
% disp(size(newImage));

% initialize a temporary matrix to store the resulting values
tempMatrix = [];

% disp(newH-Fh+1);
% output should be the size of the padding -- 1:10:36 of video lecture
% we want to skip whatever the stride is
for i=1:Stride:(newH - Fh + 1)
   for j=1:Stride:(newW - Fw + 1)
       % take a 3x3 block of the image from i up until 
       block = newImage(i : (i + Fh - 1), j : (j + Fw - 1));
       % take the filter and do the dot product of it
       val = sum(block .* Filter);  % results in a 1x3, so sum it
       sumVal = sum(val);
       % disp(sumVal);
       
       % store the final result into this temporary matrix 1xN
       tempMatrix = [tempMatrix, sumVal];
   end
end

% reshape the matrix
tempMatrix = reshape(tempMatrix, [paddingH, paddingW]);

% need it to be a paddingH x paddingW size and flip it left right up down
% for convolution???
% disp(tempMatrix.');
% Output = tempMatrix.';

% this ouput is without flipping it. ask seong jae when i have the chance
Output = tempMatrix;
% disp(Output);
end