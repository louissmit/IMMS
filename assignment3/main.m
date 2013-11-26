workingDir = 'pingpong';
imageNames = dir(fullfile(workingDir,'*.jpeg'));
imageNames = {imageNames.name}';

% outputVideo = VideoWriter(fullfile(workingDir,'pingpong.avi'));
% outputVideo.FrameRate = 20;
% open(outputVideo);

frame1 = imread(fullfile(workingDir,imageNames{1}));
[m,n] = size(frame1);
M = zeros(m,n,length(imageNames));

for i = 1:length(imageNames)
    frame2 = imread(fullfile(workingDir,imageNames{i}));
    M(:,:,i) = getOpticalFlow(frame1, frame2, 12);
%     writeVideo(outputVideo,img);
end

% close(outputVideo);
movie(M);
