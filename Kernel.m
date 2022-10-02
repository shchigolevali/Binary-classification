function [y] = Kernel(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if 0<=x && x<=1
    y=1/((x+0.001)^9);
else 
    y=0;
end

