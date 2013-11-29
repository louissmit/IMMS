image1 = rgb2gray(im2double(imread('left.jpg')));
image2 = rgb2gray(im2double(imread('right.jpg')));
[lframes,ldesc] = vl_sift(single(image1));
[rframes,rdesc] = vl_sift(single(image2));

[matches] = vl_ubcmatch(ldesc, rdesc);

P = 150;
r = randi([1 size(matches,2)],1,P);
N = 1;
X = [];
Y = [];
avgPm = zeros(6,1);
for p = 1:P
    i = r(p);
    index = matches(:,i);
    lframe = lframes(:,index(1));
    rframe = rframes(:,index(2));
    x = lframe(1);
    X(i) = x;
    y = lframe(2);
    Y(i) = y;
    rx = rframe(1);
    ry = rframe(2);;
    b = [rx; ry];
    A = [x y 0 0 1 0;
         0 0 x y 0 1];
    pm = linsolve(A,b);
    avgPm = avgPm + pm;
end
V = lframes(1:2,:);
X = V(1,:);
Y = V(2,:);
pX = [];
pY = [];
avgPm = avgPm / P;
for i = 1:size(matches,2)
    x = X(i);
    y = Y(i);
    A = [x y 0 0 1 0;
         0 0 x y 0 1];
    p = A * avgPm;
    pX(i) = p(1);
    pY(i) = p(2);
end
size(pX)
imshow(image1);
hold on;
scatter(X,Y,40,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',1.5);
scatter(pX,pY,40,'MarkerEdgeColor','r','MarkerFaceColor','c','LineWidth',1.5);
hold off;
figure
imshow(image2);