function [X,Y,Vx,Vy] = opticalFlow(frame1, frame2, regionSize, sigma)
    %get all points for regionSize by regionSize regions without overlapping
    borderOffset = ((regionSize-1)/2)+1;
    X = borderOffset:regionSize:size(frame1,1)-borderOffset;
    Y = borderOffset:regionSize:size(frame1,2)-borderOffset;
    

    %get flow for each point
    Vx = zeros(size(X), size(Y));
    Vy = zeros(size(X), size(Y));
    size(X)
    for i = 1:size(X,2)
        for j = 1:size(Y,2)
            [dx, dy] = pointFlow(frame1, frame2, X(i), Y(j), regionSize, sigma);
            Vx(i,j) = dx;
            Vy(i,j) = dy;
        end
    end
end


