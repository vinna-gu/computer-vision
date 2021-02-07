% Vinna Gu (vig37) 
% hw1.m

% 1. [2 pts] Generate a 1000000x1 (one million by one) vector of random numbers from a Gaussian (normal) distribution with mean of 0 and standard deviation of 5. Use Matlab's randn function.
vectorResults = 0 + 5 * randn(1000000, 1);

% 2. [3 pts] Add 1 to every value in the previous list, by using a loop. To determine how many times to loop, use Matlab's size function. Time this operation and print the number in the code. Write that number down in answers.txt. Use Matlab's documentation to find out how to time operations.
clk = clock;
vectorAdd = vectorResults;
for i = 1:1:size(vectorResults)                 % loop from 1 to the size of the results in steps of 1
    vectorAdd(i) = vectorResults(i) + 1;  
end 
disp(etime(clock, clk));

% 3. [3 pts] Now add 1 to every value in the original random vector, without using a loop. Time this operation, print the time and write it down. Use a different way to print the number than the method you used above. (See ways to print numbers at the beginning of the Matlab tutorial script.)
tic
    vectorResults + 1;
toc

% 4. [2 pts] Plot the exponential function 2.^x, for non-negative even values of x smaller than 100, without using loops.
x = 0:2:98;                                     % starting at 0, and doing even numbers up to 98 (b/c smaller and even than 100)
plot(2.^x);

% 5. [3 pts] Create two matrices A and B which, when added together, result in a 10x10 matrix C containing all numbers from 1 to 100. In other words, when I add A and B and convert the result to vector form, I should get a vector containing all numbers from 1 to 100. In code, C = A + B; assert(all(C(:) == (1:100)') == 1); Each matrix should only be created with a single command (no loops).
A = reshape(1:100, 10, 10);
B = zeros(10, 10);                              % i don't know if this is allowed?
C = A + B; 
assert(all(C(:) == (1:100)') == 1);
 
% 6. [2 pts] Create a script that prints all the values between 1 and 10, in random order, with pauses of 1 second between each two prints.
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];    
array_rand = randperm(length(array));       % printing my array in random order into array_rand

for i = 1 : numel(array_rand)               % numel gets size of array_rand
    disp(array_rand(i));
    if mod(i, 2) ~= 0                       % pauses for a second after printing two numbers
        continue;
    else
        pause(1);
    end
        
end
% 7. [3 pts] Generate two random matrices A and B, and compute their product by hand, using loops. The size of the first matrix should be [5, 3] and of the second [3, 5]. Check your code by comparing the loop-computed product with the product that you get from Matlab's A*B.
A = randi(10, 5, 3);
B = randi(10, 3, 5);
productMatlab = A * B;

% make sure the number of columns in A == number of rows in B
% (x * y) * (j * k) = x * k where y and j are the same value
result = zeros(5, 5);
% disp(size(B, 2)); %col
% disp(size(A, 1)); %row
if size(A,2) == size(B,1)
    for i = 1:size(A,1)         % for looping through the rows (5)
        for j = 1:size(B, 2)    % for looping the columns (5)
           add = 0;         
           for k = 1:3          % each row in A contains 3 numbers, each column in B contains 3 numbers
               add = add + A(i, k) * B(k, j); % for A, i = the row, k = the 1st/2nd/3rd num in that row
           end
           result(i, j) = add;  % store it back into the result matrix at position i, j
        end 
    end
end

% 8 - 11 are in normalize_rows.m, normalize_columns.m, fib.m, my_unique.m
fprintf("Display fib: ");
printfib = fib(10);
disp(printfib);
fprintf("\n");
% 12. [2 pts] Read this image into Matlab as a matrix, and write down its dimensions.
I = imread('pittsburgh.png'); % Read a PNG image
disp(size(I));                % gets the dimension of the image == 750 x 1500 x 3 pixels

% 13. [2 pts] Convert the image into grayscale.
grayScaleIm = rgb2gray(I);

% 14. [3 pts] Use the function sum and a logical operator which measures equality to a scalar, to determine and write down how many pixels in the grayscale image are equal to 6. Don't use loops.
totalPixSix = sum(grayScaleIm(:) == 6);

% 15. [3 pts] Find the darkest pixel in the image, and write its value and [row, column] in your answer sheet. Don't use loops. Hint: Convert to a vector first, and use Matlab's ind2sub function. Use Matlab's help to find out how to use that function.
darkPixel = min(grayScaleIm(:));
[row, col] = ind2sub(size(grayScaleIm), find(grayScaleIm == darkPixel)); 

% 16. [3 pts] Consider a 31x31 square (a square with side equal to 31 pixels) that is centered on the darkest pixel from the previous question. Replace all pixels in that square with white pixels (pixels with value 255). Do this with loops.
% to get the row, subtract 15 to get left side of current pixel and add 15
% to get right side of current pixel. the 1 pixel is the centered pixel
for r = row - 15:row + 15
    for c = col - 15:col + 15
        grayScaleIm(r, c) = 255;
    end
end

% 17. [3 pts] Take the previous image with the white square in it. Place a 121x121 gray square (e.g. pixel values 150) at the center of this image. This time you are NOT allowed to use loops. Hint: You can access a range of rows and columns in a matrix; see examples in the tutorial.
% center of previous image = size(row / 2), (col, 2) to get the center
centerRow = (size(grayScaleIm, 1)/2);
centerCol = (size(grayScaleIm, 2)/2);
imgCenter = [centerRow, centerCol];     % should be at 375x750

grayScaleIm(centerRow - 60 : centerRow + 60 , centerCol - 60 : centerCol + 60 ) = 150; 

% 18. [2 pts] Make a new figure, display the modified image (which includes both a white square and gray square), and save the new figure to a file using saveas(gcf, 'new_image.png').
figure;
imshow(grayScaleIm);
saveas(gcf, 'new_image.png');

% 19. [3 pts] Using the original pittsburgh.png image, compute the scalar average pixel value along each channel (R, G, B) separately, then subtract the average value per channel. Display the resulting image and write it to a file mean_sub.png. If you choose to do this using a new matrix as your image, make sure it is of the same class/datatype (uint8) as the original image; a simple cast would do the job. You may use loops.
% I = original pittbsurgh img

% separate RGB 
r = I(:,:,1); 
g = I(:,:,2);
b = I(:,:,3);

% and get the avg
rAvg = mean2(r);
gAvg = mean2(g);
bAvg = mean2(b);

% subtract that average from the RGB
r = r - rAvg;
g = g - gAvg;
b = b - bAvg; 

figure;
imshow(I);
saveas(gcf, 'mean_sub.png');