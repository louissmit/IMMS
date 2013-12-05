function testRANSAC()
%TESTRANSAC Summary of this function goes here
%   Detailed explanation goes here

    image1 = im2double(imread('boat/img1.pgm'));
    image2 = im2double(imread('boat/img4.pgm'));
    [bestPm, X1, Y1, matches1, matches2] = RANSAC(image1, image2);

    tX =[];
    tY =[];
    for i = 1:size(matches1,2)
        x = X1(matches1(i));
        y = Y1(matches1(i));
        A = [x y 0 0 1 0;
             0 0 x y 0 1];
        xPrime = A * bestPm;
        tX(i) = xPrime(1);
        tY(i) = xPrime(2);
    end
    figure
    imshow([image1 image2], []);
    hold on;
    scatter(X1,Y1,40,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',1.5);
    scatter(tX + size(image1, 2), tY, 40,'MarkerEdgeColor','r','MarkerFaceColor','c','LineWidth',1.5);
    hold off;
    figure
    M = transpose(reshape(bestPm(1:4),2,2));
    t = bestPm(5:6);
    tForm = maketform('affine',[M';t']);

    transformedimage = imtransform(image1,tForm);
    imshow(transformedimage);

end

