% energy_image.m -- PART 3.1 of HW 2
function[energyImage, Ix, Iy] = energy_image(im)
% Input is where im is the (row x col x 3)
% Output: energyImage, Ix, Iy = 2D matrices (double class) (row x col x3) 

% converting the image to grayscale before doing the gradients
im = imread(im);
grayScaleIm = rgb2gray(im);
end