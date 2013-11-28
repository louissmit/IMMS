% show harris corners
frame1 = rgb2gray(im2double(imread('building.jpg')));
harris_sigma = 1.2;
harris_threshold = 0.00001;
harris_window = 15;
figure;
imshow(frame1);
hold on;
[c,r] = HarrisCornerDetector(frame1,harris_sigma,harris_window,harris_threshold);
scatter(c,r,40,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',1.5);
hold off;

% optical flow parameters
regionSize = 15;
sigma = 0.7;

% show optical flow for spheres
frame1 = rgb2gray(im2double(imread('sphere1.ppm')));
frame2 = rgb2gray(im2double(imread('sphere2.ppm')));

[X, Y, Vx, Vy] = opticalFlow(frame1, frame2, regionSize, sigma);
figure;
imshow(frame1);
hold on;
quiver(X, Y, Vx.', Vy.');

% show optical flow for synth
frame1 = im2double(imread('synth1.pgm'));
frame2 = im2double(imread('synth2.pgm'));
[X, Y, Vx, Vy] = opticalFlow(frame1, frame2, regionSize, sigma);
figure;
imshow(frame1);
hold on;
quiver(X, Y, Vx.', Vy.');
