% im = imread('egg.jpg');
% [edges] = detectEdges(im);
% radius = 7;
% top_k =10;
% [centers] = detectCircles(im, edges, radius, top_k);
origImg = imread('jupiter.jpg');
for k=2:5
    [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k);
    figure; imshow(outputImg, meanColors); title(strcat('Quantized Fish Image for K= ', num2str(k)));
    quantizedImg = outputImg;
end
