function [new_x, new_y] = pointFlow(frame1, frame2, x, y, regionSize)
%POINTFLOW Summary of this function goes here
%   Detailed explanation goes here
    [m, n] = size(frame1);
    
    gridSizeX = m / regionSize;
    gridSizeY = n / regionSize;
    
    A = zeros(regionSize * regionSize, 2);
    Vx = zeros(gridSizeX, gridSizeY);
    Vy = zeros(gridSizeX, gridSizeY);
    
    
    [Gx,Gy] = imgradientxy(frame1);
    
    h = regionSize/2 - 1
    xshift = 0;
    yshift = 0;
    if(x < h)
        xshift = h;
    elseif(x > (h - m))
        xshift = h - m;
    end
    if(y < h)
        yshift = h;
    elseif(y > (h - m))
        yshift = h - m;
    end
    Ix = Gx((x-h):(x+h),(y-h):(y+h));
    Iy = Gx((x-h):(x+h),(y-h):(y+h));
    It = frame2 - frame1;
    
    % calculate velocity   

    A = [reshape(Ix, regionSize * regionSize, 1), reshape(Iy, regionSize * regionSize, 1)];
    b = -reshape(It,regionSize * regionSize,1);
    v = linsolve(A,b);
    Vx(i,j) = v(1);
    Vy(i,j) = v(2);

end

