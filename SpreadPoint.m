function [] = SpreadPoint(coord, threshold, recursionDepth)
    global mask;
    global gradients;
    global image;
    [rows, cols] = size(mask);
    try
    if (recursionDepth == 0 || mask(coord(1), coord(2)) ~= 0)
        return;
    end
    catch
        return;
    end
    mask(coord(1), coord(2)) = 1;
    [n, k] = Neighbors(coord, rows, cols);
    for i=1:k
        neigh = n(i,:);
        if (mask(neigh(1), neigh(2)) ~= 0) 
            continue;
        end
        grad = gradients(neigh(1), neigh(2));
        colorDiff = double(abs(image(neigh(1), neigh(2)) - image(coord(1), coord(2)))) / 255.0;
        cost = grad * 0.800 + colorDiff * 0.500;
        if (cost <= threshold)
            SpreadPoint(neigh, threshold, recursionDepth-1);
        end
    end
end

function [neigh, howMany] = Neighbors(coord, rows, cols)
    neigh = [-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;];
    count = 1;
    for i=-1:1
        for j=-1:1
            k = i + coord(1);
            l = j + coord(2);
            if (i == 0 && j == 0)
                continue;
            end
            if (k < 1 || k > rows || l < 1 || l > cols)
                continue;
            end
            neigh(count, :) = [k, l];
            count = count + 1;
        end
    end
    howMany = count - 1;
end
