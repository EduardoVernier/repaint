function [ labelMap ] = SpreadPoint( coords, grayimg, cost, label, labelMap, ...
                                            gradients, edges)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if (cost <= 0 || labelMap(coords(1), coords(2)) ~= 0) 
        return; 
    end
    [rows, cols] = size(grayimg);
    [n, k] = Neighbors(coords, rows, cols);
    labelMap(coords(1), coords(2)) = label;
    newCost = cost - gradients(coords(1), coords(2));
    for i = 1:k
        
        labels = SpreadPoint(n(i,:), grayimg, newCost, label, labelMap, gradients, edges);
        labelMap = labels | labelMap;
    end
end

function [neigh, howMany] = Neighbors(coord, rows, cols)
    neigh = [-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;-1,-1;];
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
