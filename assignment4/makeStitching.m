function [ stitchedImage ] = makeStitching( image1, image2 )

    [bestPm, X1, Y1] = RANSAC(image2, image1);
    
    M = transpose(reshape(bestPm(1:4),2,2));
    t = bestPm(5:6);
 
    tForm = maketform('affine',[M';t']);
    transformedimage = imtransform(image2,tForm);
    imshow(transformedimage);
    
    [height1, width1] = size(image1)
    [height2, width2] = size(image2);
    [heightT, widthT] = size(transformedimage);
    
    A = [width1 height1 0 0 1 0;
         0 0 width1 height1 0 1];
    tCorners = round(A * bestPm);
    
    maxHeight = max([height1, heightT, tCorners(2)])
    maxWidth = max([width1, widthT, tCorners(1)])
    
    result = zeros(maxHeight, maxWidth);
    result((tCorners(2)-heightT):maxHeight-1, (tCorners(1)-widthT):maxWidth-1) = transformedimage;
    result(1:height1, 1:width1) = image1;
    
    
    figure
    imshow(image1);
    figure
    imshow(result);
end

