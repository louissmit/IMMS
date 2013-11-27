workingDir = 'pingpong';
imageNames = dir(fullfile(workingDir,'*.jpeg'));
imageNames = {imageNames.name};

frame1 = rgb2gray(im2double(imread(fullfile(workingDir,imageNames{1}))));
[m,n] = size(frame1);
[c,r] = HarrisCornerDetector(frame1,0.7,15,0.0002);
regionSize = 16;
new_c = c;
new_r = r;

for i = 1:length(imageNames)
    frame2 = rgb2gray(im2double(imread(fullfile(workingDir,imageNames{i}))));
    imshow(frame1)
    hold on
%     [Vx, Vy] = opticalFlow(frame1, frame2, regionSize);
% 
%     X = 1:regionSize:n;
%     Y = 1:regionSize:m;
%     quiver(X, Y, Vx, Vy);
    scatter(c,r,40,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',1.5)
    hold off
    
    for j = 1:length(c)
        if(c(j) < n & r(j) < m)
            [dx, dy] = pointFlow(frame1, frame2, c(j), r(j), 16);
            new_c(j) = c(j) + round(dx);
            new_r(j) = r(j) + round(dy);

        end
    end
    c = new_c;
    r = new_r;
    F(i) = getframe;
    frame1 = frame2;

end

movie(F, 5, 20);
