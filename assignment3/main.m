workingDir = 'pingpong';
imageNames = dir(fullfile(workingDir,'*.jpeg'));
imageNames = {imageNames.name}';

% outputVideo = VideoWriter(fullfile(workingDir,'pingpong.avi'));
% outputVideo.FrameRate = 20;
% open(outputVideo);

frame1 = rgb2gray(im2double(imread(fullfile(workingDir,imageNames{1}))));
[m,n] = size(frame1);
% M = zeros(m,n,length(imageNames));
% M = repmat(struct('x',1), length(imageNames), 1 );
figure('Renderer', 'zbuffer');
for i = 1:length(imageNames)
    frame2 = rgb2gray(im2double(imread(fullfile(workingDir,imageNames{i}))));
    
    opticalFlow(frame1, frame2, 8);
    F(i) = getframe;
    frame1 = frame2;
%     writeVideo(outputVideo,img);
end

% close(outputVideo);
movie(F);
