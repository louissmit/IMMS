% show sphere optical flow
regionSize = 20;
figure
frame1 = rgb2gray(im2double(imread('sphere1.ppm')));
frame2 = rgb2gray(im2double(imread('sphere2.ppm')));
[m, n] = size(frame1);
[Vx, Vy] = opticalFlow(frame1, frame2, regionSize);
imshow(frame1);
hold on
X = 1:regionSize:n;
Y = 1:regionSize:m;
size(Vx)
size(X)
quiver(X, Y, Vx, Vy);
hold off


% show synth optical flow
regionSize = 8;
figure
frame1 = im2double(imread('synth1.pgm'));
frame2 = im2double(imread('synth2.pgm'));
[m, n] = size(frame1);
[Vx, Vy] = opticalFlow(frame1, frame2, regionSize);
imshow(frame1);
hold on
X = 1:regionSize:n;
Y = 1:regionSize:m;
plot = quiver(X, Y, Vx, Vy);
hold off

