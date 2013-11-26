frame1 = rgb2gray(im2double(imread('sphere1.ppm')));
frame2 = rgb2gray(im2double(imread('sphere2.ppm')));
opticalFlow(frame1, frame2, 10);
figure
frame1 = im2double(imread('synth1.pgm'));
frame2 = im2double(imread('synth2.pgm'));
opticalFlow(frame1, frame2, 8);
