image1 = rgb2gray(im2double(imread('left.jpg')));
image2 = rgb2gray(im2double(imread('right.jpg')));
[lframes,ldesc] = vl_sift(single(image1));
[rframes,rdesc] = vl_sift(single(image2));

[matches] = vl_ubcmatch(ldesc, rdesc);

P = 20;
N = 1;
X = [];
Y = [];
PM = [];
pY = [];
for i = 1:P
    index = matches(:,i);
    lframe = lframes(:,index(1));
    rframe = rframes(:,index(2));
    x = lframe(1)
    X(i) = x;
    y = lframe(2);
    Y(i) = y;
    rx = rframe(1);
    ry = rframe(2);;
    b = [rx; ry];
    A = [x y 0 0 1 0;
         0 0 x y 0 1];
    pm = linsolve(A,b);
end
imshow(image1);
hold on;
scatter(X,Y,40,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',1.5);
scatter(pX,pY,40,'MarkerEdgeColor','r','MarkerFaceColor','c','LineWidth',1.5);
hold off;
figure
imshow(image2);