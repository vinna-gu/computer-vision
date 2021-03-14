% mosaic.m

% % 1st take in the keble images and show them in separate figures
% figure 1
figure;
imshow('keble1.png')
% imshow('uttower1.jpeg')
impixelinfo;

% figure 2
figure;
imshow('keble2.png')
% imshow('uttower2.jpeg')
impixelinfo;

% Examine the images and picked four points on figure 1 into PA and those
% same four points for figure 2 into PB
% keble image
PA = [164, 77;
      279, 123;
      324, 98;
      253, 33];
PB = [ 67, 89;
       183, 139;
       226, 114;
       159, 44];

% % uttower image   
% PA = [561, 321;
%       373, 291;
%       325, 508;
%       103, 504];
% PB = [1019, 333;
%        814, 320;
%        781, 541;
%        566, 543];

% use the function H = estimate_homography(PA, PB) and use that H value,
% pick one new point in the first image, use H to detect the point in the
% second image (without manually having to do it)
H = estimate_homography(PA, PB);

% pick a new point and use the apply_homography
% keble
p2 = apply_homography([269, 42, 1], H);

% display the first image and the second image side by side
% keble
% figure;
% subplot(1, 2, 1);
% hold on;
% imshow(imread('keble1.png'));
% plot(269, 42,'g.', 'MarkerSize', 25);
% title(['keble1 image']);
% 
% subplot(1, 2, 2);
% hold on;
% imshow(imread('keble2.png'));
% plot(p2(1), p2(2), 'y.', 'MarkerSize', 25);
% title(['keble2 image']);
% hold off;

% % uttower
% p2 = apply_homography([445, 513, 1], H);

% figure;
% subplot(1, 2, 1);
% hold on;
% imshow(imread('uttower1.jpeg'));
% plot(445, 513 ,'g.', 'MarkerSize', 25);
% title(['uttower1 image']);
% 
% subplot(1, 2, 2);
% hold on;
% imshow(imread('uttower2.jpeg'));
% plot(p2(1), p2(2), 'y.', 'MarkerSize', 25);
% title(['uttower2 image']);
% hold off;


% ~~~~ STITCHING IMAGES PART ~~~~~
% keble_mosaic.png
img1 = imread('keble1.png');
img2 = imread('keble2.png');
img2 = im2double(img2);         % set the image to a double
img1 = im2double(img1);

% get the size of image 2
img2x = size(img2, 1);
img2y = size(img2, 2);

% create a canvas that replicates the size of image2 3 times in the 
% horizontal and 3 times in the vertical direction, 
canvas = zeros((img2x * 3), (img2y * 3));

% size of the canvas is 795 x 1083 && size of the image2 = 265 x 361
% starting from position row266:530 col362:722, place img2 in center
canvas((img2x + 1): (img2x * 2), (img2y + 1): (img2y * 2), 1:3) = img2;

% for each pixel at location p1 in image1
for i=1:size(img1, 1)
   for j=1:size(img1, 2)
       % apply the estimated homography to determine location p2
       p2 = apply_homography([i, j, 1],H);

       % round x and y values that were given from p2 using ceil/floor
       floorX = floor(p2(1));
       floorY = floor(p2(2));
       ceilX = ceil(p2(1));
       ceilY = ceil(p2(2));
       
       % adding the values of the given xy from p2 to fit with canvas
       xCeilCanvas = ceilX + img2y;
       xFloorCanvas = floorX + img2y;
       yCeilCanvas = ceilY + img2x;
       yFloorCanvas = floorY + img2x;

       % store into the canvas
       canvas(xCeilCanvas, yCeilCanvas, 1:3) = img1(i, j, 1:3);
       canvas(xCeilCanvas, yFloorCanvas, 1:3) = img1(i, j, 1:3);
       canvas(xFloorCanvas, yCeilCanvas, 1:3) = img1(i, j, 1:3);
       canvas(xFloorCanvas, yFloorCanvas, 1:3) = img1(i, j, 1:3);
        
   end
end


figure;
imshow(canvas);
