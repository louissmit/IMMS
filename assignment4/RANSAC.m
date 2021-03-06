function [ bestPm, X1, Y1, matches1, matches2] = RANSAC( image1, image2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [frames1,ldesc] = vl_sift(single(image1));
    [frames2,rdesc] = vl_sift(single(image2));

    [matches] = vl_ubcmatch(ldesc, rdesc);

    P = 4;
    N = 5000;

    L = frames1(1:2,:);
    X1 = L(1,:);
    Y1 = L(2,:);
    matches1 = matches(1,:);

    R = frames2(1:2,:);
    X2 = R(1,:);
    Y2 = R(2,:);
    matches2 = matches(2,:);

    randomX1 = [];
    randomY1 = [];
    randomX2 = [];
    randomY2 = [];
    pm = zeros(6,1);

    bestCount = 0;
    bestPm = [];
    r = randi([1 size(matches,2)],1,P);
    for n = 1:N
        for p = 1:P
            i = r(p);

            randomX1(p) = X1(matches1(i));
            randomY1(p) = Y1(matches1(i));

            randomX2(p) = X2(matches2(i));
            randomY2(p) = Y2(matches2(i));

        end
        A = zeros(2*P, 6);
        A(1:2:2*P,1) = randomX1;
        A(1:2:2*P,2) = randomY1;
        A(2:2:2*P,3) = randomX1;
        A(2:2:2*P,4) = randomY1;
        A(1:2:2*P,5) = 1;
        A(2:2:2*P,6) = 1;

        b = zeros(2*P,1);
        b(1:2:2*P) = randomX2;
        b(2:2:2*P) = randomY2;

        pm = pinv(A)*b;

        inlierCount = 0;
        for i = 1:size(matches,2)
            x = X1(matches1(i));
            y = Y1(matches1(i));
            A = [x y 0 0 1 0;
                 0 0 x y 0 1];
            xPrime = A * pm;
            distance = norm(xPrime - [X2(matches2(i)); Y2(matches2(i))]);
            if(distance < 10)
                inlierCount = inlierCount + 1;
            end
        end
        if(inlierCount > bestCount)
            bestPm = pm;
        end
    end


end

