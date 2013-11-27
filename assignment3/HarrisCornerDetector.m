function [c, r] = HarrisCornerDetector (image, sigma, window_size, threshold)
%computing Gaussian function implemented in previous assignment
G = gaussian(sigma);
% create the gaussian filters using 1st order derivatives
Gx = gaussianDer(G,sigma);
Gy = transpose(Gx);
% convolution according to Ix, Iy
Ix = imfilter(image,Gx,'replicate','same');
Iy = imfilter(image,Gy,'replicate','same');
%computing A,B,C taking in consideration their expressions (formula 8)
A = imfilter(Ix.^2,G,G','replicate','same');
B = imfilter(Ix.*Iy,G,G','replicate','same');
C = imfilter(Iy.^2,G,G','replicate','same');
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
%if the point is located at edges then it can't be a corner point
      windowX_Left = rowP(i) - window_size;
        if windowX_Left < 1
        windowX_Left = 1;
        end
%finding corner points for X
    windowX_Right = rowP(i) + window_size;
        if windowX_Right > size(H,1)
        windowX_Right = size(H,1);
        end
%if the point is located at edges then it can't be a corner point
    windowY_Top = columnP(i) - window_size;
        if windowY_Top < 1
        windowY_Top = 1;
        end
%finding corner points for Y
    windowY_Bottom = columnP(i) + window_size;
        if windowY_Bottom > size(H,2)
        windowY_Bottom = size(H,2); 
        end
%constructing the NxN window 
window = H(windowX_Left:windowX_Right,windowY_Top:windowY_Bottom);
%finding the corner points which are local maxima of H
    if H(rowP(i),columnP(i)) == max(max(window))
        r = [r rowP(i)];
        c = [c columnP(i)];
    end
end
end

