workingDir = 'pingpong';
imageNames = dir(fullfile(workingDir,'*.jpeg'));
imageNames = {imageNames.name};
writerObj = VideoWriter(workingDir,'MPEG-4')
writerObj.FrameRate = 10;

% all parameters
optflow_window = 15;
optflow_sigma = 0.7;
harris_sigma = 0.9;
harris_threshold = 0.00009;
harris_window = 15;

% read first frame and detect corners
frame1 = rgb2gray(im2double(imread(fullfile(workingDir,imageNames{1}))));
[m,n] = size(frame1);
[c,r] = HarrisCornerDetector(frame1,harris_sigma,harris_window,harris_threshold);

% initialize vectors
new_c = c;
new_r = r;
dxa = ones(1, length(c));
dya = ones(1, length(c));

% open videoWriter and loop through images
open(writerObj);
for i = 1:length(imageNames)
    frame2 = rgb2gray(im2double(imread(fullfile(workingDir,imageNames{i}))));
    imshow(frame1)
    hold on
    % plot edge points       
    scatter(c,r,40,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',1.5);
    % update points with Lucas-Kanade    
    for j = 1:length(c)
        % only if the pixel doesnt fall outside of image        
        if(c(j) < n & r(j) < m)
            [dx, dy] = pointFlow(frame1, frame2, c(j), r(j), optflow_window, optflow_sigma);
            dxa(j) = dx;
            dya(j) = dy;
            new_c(j) = c(j) + round(dx);
            new_r(j) = r(j) + round(dy);

        end
    end
    % plot velocity vectors    
    quiver(new_c, new_r, dxa, dya);
    hold off;
    % update and write a frame to video    
    c = new_c;
    r = new_r;
    writeVideo(writerObj,getframe);
    frame1 = frame2;

end
close(writerObj);
