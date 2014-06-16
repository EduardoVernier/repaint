function [nextMap] = SpreadLine(points, costPerPoint, baseColor, image)
    
    if ndims(image) > 2
        grayImg = rgb2gray(image);
    else
        grayImg = image;
    end
    [gradients, ~] = imgradient(grayImg, 'prewitt');
    nextMap = zeros(size(grayImg));
    points = uint32(points);
    for i=1:size(points,1)
        newMap = SpreadPoint(points(i,:), grayImg, costPerPoint, 1, nextMap, gradients, []);
        nextMap = newMap | nextMap;
    end
    
end