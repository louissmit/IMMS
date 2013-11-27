function [dx, dy] = pointFlow(frame1, frame2, x, y, regionSize, sigma)
%POINTFLOW Summary of this function goes here
%   Detailed explanation goes here
    [m, n] = size(frame1);
    %  [Gx,Gy] = imgradientxy(frame1);
    G = gaussian(sigma);
    % create the gaussian filters using 1st order derivatives
    Gx = gaussianDer(G,sigma);
    Gy = transpose(Gx);
    Gx = conv2(frame1,Gx,'same');
    Gy = conv2(frame1,Gy,'same');
    
    % extrude the window out of the gradient matrices
    % if the x,y is near an edge, we decrease window size    
    h = regionSize/2;
    lh = h;
    rh = h;
    uh = h;
    dh = h;
    if(x <= h)
        lh = x-1;
    elseif(x >= (n - h))
        rh = abs(x - n);
    end
    if(y <= h)
        dh = y-1;
    elseif(y >= (m - h))
        uh = abs(y - m);
    end
    Ix = Gx((y-dh):(y+uh),(x-lh):(x+rh));
    Iy = Gy((y-dh):(y+uh),(x-lh):(x+rh));
    It = frame2 - frame1;
    It = It((y-dh):(y+uh),(x-lh):(x+rh));
    
    [im, in] = size(Ix);
    vSize = im*in;
    % calculate velocity   
    A = [reshape(Ix, vSize, 1), reshape(Iy, vSize, 1)];
    b = -reshape(It,vSize,1);
    v = linsolve(A,b);
    k = 1;
    dx = k * v(1);
    dy = k * v(2);

end

