function opticalFlow(frame1, frame2, regionSize)
    
    [m, n] = size(frame1);
    gridSize = n / regionSize;
    
    % calculate difference and gradient
    diff = frame2 - frame1;
    [Gx,Gy] = imgradientxy(frame1);

    % divide gradients into regions
    divider = repmat([regionSize], gridSize, 1);
    Ix = mat2cell(Gx, divider, divider);
    Iy = mat2cell(Gy, divider, divider);
    It = mat2cell(diff, divider, divider);

    A = zeros(regionSize * regionSize, 2);
    Vx = zeros(gridSize, gridSize);
    Vy = zeros(gridSize, gridSize);
    
    % calculate velocity   
    for i = 1:gridSize
        for j = 1:gridSize
            A = [reshape(cell2mat(Ix(i,j)), regionSize * regionSize, 1), reshape(cell2mat(Iy(i,j)), regionSize * regionSize, 1)];
            b = -reshape(cell2mat(It(i,j)),regionSize * regionSize,1);
            v = linsolve(A,b);
            Vx(i,j) = v(1);
            Vy(i,j) = v(2);
        end
    end

    figure
    imshow(frame1);
    hold on
    X = 1:regionSize:n;
    Y = 1:regionSize:n;
    
    quiver(X, Y, Vx, Vy);
    hold off
end


