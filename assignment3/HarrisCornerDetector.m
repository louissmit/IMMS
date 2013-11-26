function [c, r] = HarrisCornerDetector (image, sigma, window_size, threshold)
% image = im2double(imread(image_path));
% % convert image to gray if image is in rgb
% if(size(image, 3) == 3)
%     image = rgb2gray(image);
% end
% %computing Gaussian function implemented in previous assignment
G = gaussian(sigma);
% create the gaussian filters using 1st order derivatives
Gx = gaussianDer(G,sigma);
Gy = transpose(Gx);
% convolution according to Ix, Iy
Ix = conv2(image,Gx,'same');
Iy = conv2(image,Gy,'same');
%computing A,B,C according to the statement
A = conv2(G,G',Ix.^2,'same');
B = conv2(G,G',Ix.*Iy,'same');
C = conv2(G,G',Iy.^2,'same');
%computing the 'cornerness' H
H = (A.*C - B.^2) - 0.04*(A + C).^2;
%set to positive values 
[rowP,columnP] = find(H>threshold);
%initialize the rows and columns for detecting corner points
r = [];
c = [];
%defining the window (centred around a point)
window_size = floor(window_size/2);
%determine the corner points
for i = 1:size(rowP,1)
      windowX_Left = rowP(i) - window_size;
        if windowX_Left < 1
        windowX_Left = 1;
        end
    windowX_Right = rowP(i) + window_size;
        if windowX_Right > size(H,1)
        windowX_Right = size(H,1);
        end
    windowY_Top = columnP(i) - window_size;
        if windowY_Top < 1
        windowY_Top = 1;
        end
    windowY_Bottom = columnP(i) + window_size;
        if windowY_Bottom > size(H,2)
        windowY_Bottom = size(H,2); 
        end
window = H(windowX_Left:windowX_Right,windowY_Top:windowY_Bottom);
%finding the corner points which are local maxima of H
    if H(rowP(i),columnP(i)) == max(max(window))
        r = [r rowP(i)];
        c = [c columnP(i)];
    end
end
% 
% %image derivatives considering Ix and Iy
% figure('name','image derivative Ix'); imshow(Ix,[]);
% figure('name','image derivative Iy'); imshow(Iy,[]);
% %image with the plotted corner points
% figure('name','Plotting Corner Points'); imshow(image); 
% hold on; 
%image containing plotted corner points

end

