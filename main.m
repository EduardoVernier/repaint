%{
GLOBAL_COLOR = 0;
global labels;
parfor i=1:2
    if (i==1)
        color = uisetcolor;
        GLOBAL_COLOR = color;
    else
        sketch('init', GLOBAL_COLOR);
    end
end

%}
clc;
clear all;
close all;

global pathX;
global pathY;
global imageFile;
global image;
global mask;
global gradients;
global figMask;
imageFile = 'images/planes2.jpg';
sketch 'init'