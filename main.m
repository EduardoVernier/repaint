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
imageFile = 'coins.png';
sketch 'init'