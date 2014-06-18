function [ blurred_mask ] = FilterMask( input_mask )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    h = fspecial('gaussian', 20, 2.5);
    blurred_mask = imfilter(input_mask, h);
end

