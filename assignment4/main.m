image1 = rgb2gray(im2double(imread('left.jpg')));
image2 = rgb2gray(im2double(imread('right.jpg')));

makeStitching(image1, image2);