function [new_x, new_y] = pointFlow(frame1, frame2, x, y, regionSize)
%POINTFLOW Summary of this function goes here
%   Detailed explanation goes here
    [m, n] = size(frame1);
    
    [Gx,Gy] = imgradientxy(frame1);
    
    h = regionSize/2;
    lh = h;
    rh = h;
    uh = h;
    dh = h;
    if(x < h)
        lh = x-1;
    elseif(x > (n - h))
        rh = x - n;
    end
    if(y < h)
        dh = y-1;
    elseif(y > (m - h))
        uh = y - m;
    end
    Ix = Gx((y-dh):(y+uh),(x-lh):(x+rh));
    Iy = Gx((y-dh):(y+uh),(x-lh):(x+rh));
    It = frame2 - frame1;
    It = It((y-dh):(y+uh),(x-lh):(x+rh));
    
    [im, in] = size(Ix);
    vSize = im*in;
    % calculate velocity   
    A = [reshape(Ix, vSize, 1), reshape(Iy, vSize, 1)];
    b = -reshape(It,vSize,1);
    v = linsolve(A,b);
    new_x = v(1);
    new_y = v(2);

end

