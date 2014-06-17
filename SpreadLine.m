function [ mask ] = SpreadLine(points, threshold, recursionDepth)
    global image;
    global gradients;
    
    for i=1:size(points,1)
        SpreadPoint(points(i,:), threshold, recursionDepth);
    end
end