function [ output_args ] = FilterMask( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 h = fspecial('gaussian', 3, 0.5);
mFiltered = imfilter(mask, h);
imshow(mFiltered);
end

