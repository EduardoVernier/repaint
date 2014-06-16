function [ zeroCross ] = ZeroCrossing( img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    edges = edge(img, 'canny');
    edges(edges ~= 0) = 1;
    zeroCross = edges;
end

