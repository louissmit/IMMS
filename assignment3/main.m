function getSpheresOF()
    frame1 = rgb2gray(im2double(imread('sphere1.ppm')));
    frame2 = rgb2gray(im2double(imread('sphere2.ppm')));
    getOpticalFlow(frame1, frame2, 10);
end

function getSynthOF()
    frame1 = im2double(imread('synth1.pgm'));
    frame2 = im2double(imread('synth2.pgm'));
    getOpticalFlow(frame1, frame2, 8);
end

function getOpticalFlow(frame1, frame2, regionSize)
    
    [m, n] = size(frame1);
%     regionSize = 8;
    gridSize = n / regionSize;


    diff = imabsdiff(frame1, frame2);
    [Gx,Gy] = imgradientxy(frame1);

    divider = repmat([regionSize], gridSize, 1);
    Ix = mat2cell(Gx, divider, divider);
    Iy = mat2cell(Gy, divider, divider);
    It = mat2cell(diff, divider, divider);

    A = zeros(regionSize * regionSize, 2);
    Vx = zeros(gridSize, gridSize);
    Vy = zeros(gridSize, gridSize);

    for i = 1:gridSize
        for j = 1:gridSize
            A = [reshape(cell2mat(Ix(i,j)), regionSize * regionSize, 1), reshape(cell2mat(Iy(i,j)), regionSize * regionSize, 1)];
            b = -reshape(cell2mat(It(i,j)),regionSize * regionSize,1);
            v = linsolve(A,b);
            Vx(i,j) = v(1);
            Vy(i,j) = v(2);
        end
    end

    X = 1:gridSize;
    Y = 1:gridSize;
    quiver(X, Y, Vx, Vy);
end


