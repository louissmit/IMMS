function [plot] = opticalFlow(frame1, frame2, regionSize)
    
    [m, n] = size(frame1);
    gridSizeX = m / regionSize;
    gridSizeY = n / regionSize;
    
    
    % calculate difference and gradient
    diff = frame2 - frame1;
    [Gx,Gy] = imgradientxy(frame1);

    % divide gradients into regions
    dividerX = repmat([regionSize], gridSizeX, 1);
    dividerY = repmat([regionSize], gridSizeY, 1);
    
    Ix = mat2cell(Gx, dividerX, dividerY);
    Iy = mat2cell(Gy, dividerX, dividerY);
    It = mat2cell(diff, dividerX, dividerY);

    A = zeros(regionSize * regionSize, 2);
    Vx = zeros(gridSizeX, gridSizeY);
    Vy = zeros(gridSizeX, gridSizeY);
    
    % calculate velocity   
    for i = 1:gridSizeX
        for j = 1:gridSizeY
            A = [reshape(cell2mat(Ix(i,j)), regionSize * regionSize, 1), reshape(cell2mat(Iy(i,j)), regionSize * regionSize, 1)];
            b = -reshape(cell2mat(It(i,j)),regionSize * regionSize,1);
            v = linsolve(A,b);
            Vx(i,j) = v(1);
            Vy(i,j) = v(2);
        end
    end

    hold on
    X = 1:regionSize:m;
    Y = 1:regionSize:n;
    plot = quiver(X, Y, Vx, Vy);
    hold off
end


