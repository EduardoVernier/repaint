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
global color;
global sensitivity;
sensitivity = 0.2;
color = [0 0 0];
[FileName,PathName] = uigetfile('*','Select the image');
file = strcat(PathName, FileName);
imageFile = file;
if (file ~= 0)
    sketch 'init'
end