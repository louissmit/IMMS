function [ result ] = getSift(directory, imageNames, image_index, sift_type, dense)
%GETIMAGE Summary of this function goes here
%   Detailed explanation goes here;
    image = single(im2double(imread(fullfile(directory,imageNames{image_index}))));
    result = [];

    if(size(image,3) == 3)
        R = image(:,:,1);
        G = image(:,:,2);
        B = image(:,:,3);
    else
        R = image;
        G = image;
        B = image;
    end
    
    switch sift_type
        case'grey_scale'
            if(size(image,3) == 3)
                image = rgb2gray(image);
            end
            
            result = getDescriptors(image, dense);
            
        case 'rgb'
            R_desc = getDescriptors(R, dense);
            G_desc = getDescriptors(G, dense);
            B_desc = getDescriptors(B, dense);
            
            result = [R_desc, G_desc, B_desc];
            
        case 'opponent'
            [O1,O2,O3] = getOpponent(R,G,B)
            
            O1_desc = getDescriptors(O1, dense);
            O2_desc = getDescriptors(O2, dense);
            O3_desc = getDescriptors(O3, dense);
            
            result = [O1_desc, O2_desc, O3_desc];
    end
end

function [desc] = getDescriptors(image, dense)
    if(dense)
        [frames, desc] = vl_dsift(image);
    else
        [frames, desc] = vl_sift(image);
    end
end

function [O1,O2,O3] = getOpponent(R,G,B)
    O1 = (R-G)./sqrt(2.0);
    O2 = (R+G-2.*B)./sqrt(6.0);
    O3 = (R+G+B)./sqrt(3.0);
end