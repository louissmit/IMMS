function [dx, dy] = pointFlow(frame1, frame2, x, y, regionSize, sigma)
%POINTFLOW Calculates velocity for point x, y based on frame1 and frame2.
%regionSize determines the size of the window around x,y.
    [m, n] = size(frame1);
    G = gaussian(sigma);
    % calculate image gradients for both frames
    Gx = gaussianDer(G,sigma);
    Gy = transpose(Gx);
    Gx1 = conv2(frame1,Gx,'same');
    Gy1 = conv2(frame1,Gy,'same');
    Gx2 = conv2(frame2,Gx,'same');
    Gy2 = conv2(frame2,Gy,'same');
    
    % average the gradients of both frames
    Gx = (Gx1 + Gx2) / 2;
    Gy = (Gy1 + Gy2) / 2;
    
    % if the x,y is near an edge, we decrease window size    
    halfWindow = (regionSize-1) / 2;
    leftBound = halfWindow;
    rightBound = halfWindow;
    upperBound = halfWindow;
    lowerBound = halfWindow;
    if(x <= halfWindow)
        leftBound = x-1;
    elseif(x >= (n - halfWindow))
        rightBound = abs(x - n);
    end
    if(y <= halfWindow)
        lowerBound = y-1;
    elseif(y >= (m - halfWindow))
        upperBound = abs(y - m);
    end
    % extrude the window out of the gradient matrices
    Ix = Gx((y-lowerBound):(y+upperBound),(x-leftBound):(x+rightBound));
    Iy = Gy((y-lowerBound):(y+upperBound),(x-leftBound):(x+rightBound));
    It = frame2 - frame1;
    It = It((y-lowerBound):(y+upperBound),(x-leftBound):(x+rightBound));
    
    [im, in] = size(Ix);
    vSize = im*in;
    % calculate velocity
    A = [reshape(Ix, vSize, 1), reshape(Iy, vSize, 1)];
    b = -reshape(It,vSize,1);
    v = linsolve(A,b);
    dx = v(1);
    dy = v(2);
end

