% hybrid_image.m -- PART 2 of HW 2
% set(0, 'DefaultFigureVisible', 'on');
% 2. [3 pts] In a script hybrid_image.m, read in the first image in the pair as im1 and the second as im2. 
% Convert both images to grayscale, and resize them to the same square size (e.g. 512x512).
im1 = imread('baby_happy.jpg');
im2 = imread('baby_weird.jpg');

% convert to grayscale and resized to 512 x 512
im1 = imresize(rgb2gray(im1), [512, 512]);
im2 = imresize(rgb2gray(im2), [512, 512]);

% 3. [2 pts] Apply a Gaussian filter to both, using e.g. imgaussfilt(im1, 10, 'FilterSize', 31). 
% Save the results as im1_blur, im2_blur.
im1_blur = imgaussfilt(im1, 10, 'FilterSize', 31);
im2_blur = imgaussfilt(im2, 10, 'FilterSize', 31);

% 4. [2 pts] Obtain the detail image, by subtracting im2_blur from im2, and 
% save the result as im2_detail.
im2_detail = im2 - im2_blur;

% 5. [3 pts] Now add im1_blur and im2_detail, show the image, save it as 
% 'hybrid.png', and include it with your submission. 
% Play with scaling it up and down (by dragging the corner of the Matlab figure) to see the "hybrid" effect.
hybrid = im1_blur + im2_detail;
figure;
imshow(hybrid);
saveas(gcf, strcat('hybrid.png'));