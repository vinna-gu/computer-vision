% filter_responses.m -- PART 1 of HW 2
% set(0, 'DefaultFigureVisible', 'off');
% 3. [4 pts] In a script filter_responses.m, use a cell array to store the list of filenames so you can loop over them (e.g. filenames{i}). 
% Read in all images, convert them to grayscale, and resize them to the same square size (e.g. 100x100), so that the visual map of responses 
% (filtering outputs) can be more comparable across images. Compute the cross-correlation of each image with each of the 48 filters using imfilter.

% get set of filters where each filter = 49x49 with 48 filters(k) --> F(:, :, k)
F = makeLMfilters;

% cell array to store all the images
filenames = {'cardinal1.jpg', 'cardinal2.jpg', 'leopard1.jpg', 'leopard2.jpg', 'panda1.jpg', 'panda2.jpg'};

% loop through the array to read, convert to grayscale and resize
for i = 1: numel(filenames)
    readImage = imread(filenames{i});
    
    % convert to grey image and then resize it
    grayScaleIm = rgb2gray(readImage);
    imageSized = imresize(grayScaleIm, [100, 100]); 
    
    % cross correlate each grayscaled image using imfilter by looping from 1 - 48 to get the filters?
    for k = 1:48
        filterPic = imfilter(imageSized, F(:,:,k), 'corr');
        
        % 4. [4 pts] For each filter, generate a 2x4 subplot showing the following subplot rows: 
        % (1) the filter subplot and then a blank subplot
        subplot(2, 4, 1);               % 2 x 4 & 1 being the 1st subplot
        imagesc(F(:,:,k));
        
        % blank subplot
        delete(subplot(2, 4, 2));
        
        % i b/c the 6 images which is the cardinal, leopard and panda pics
        switch i
            case 1
                subplot(2, 4, i + 2);   % i + 2 because the first 2 images are the filter and then a blank subplot
                imagesc(filterPic);
                title('cardinal1.jpg'); % giving image a title like the example in hwstarter
            case 2 
                subplot(2, 4, i + 2);
                imagesc(filterPic);
                title('cardinal2.jpg');
            case 3  
                subplot(2, 4, i + 2);
                imagesc(filterPic);
                title('leopard1.jpg');
            case 4
                subplot(2, 4, i + 2);
                imagesc(filterPic);
                title('leopard2.jpg');
            case 5
                subplot(2, 4, i + 2);
                imagesc(filterPic);
                title('panda1.jpg');
            case 6
                subplot(2, 4, i + 2);
                imagesc(filterPic);
                title('panda2.jpg');
        end
        saveas(gcf, strcat('responses_to_filter_', num2str(k), '.png')); % we want a filter on each image 48 times
    end 
end