
function [new_img] = RegGrow(line,image,color,threshold)
    if ndims(image) > 2 
        gray = rgb2gray(image);
    else
        gray = image;
    end
    labels = zeros(size(gray));
    RegionGrowing(line,gray,color,threshold);
end

function [ new_img ] = RegionGrowing( line, image, color , threshold )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
   
    [rows,cols] = size(image);
    for i=1:size(line,1)
       px = line(i,:);
       if (labels(px(1), px(2)) ~= 0) 
           return;
       end
       labels(px(1), px(2)) = 1;
       [n,howMany] = Neighborhood(px, rows, cols);
       RegionGrowing(n(1:howMany,:), image);
       
    end
end

function [n,count] = Neighborhood(pixel, rows, cols)
    count = 1;
    n = [ -1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1];
    for k = -1:1
        for l = -1:1
            i = k + pixel(1);
            j = l + pixel(2);
            if (k == 0 && l == 0)
                continue; 
            end
            if (i > rows)
                continue;
            end
            if (j > cols)
                continue;
            end
            if (i < 1)
                continue;
            end
            if (j < 1)
                continue;
            end
            n(count,:) = [i,j];
            count = count + 1;
        end
    end
    count = count - 1;
end