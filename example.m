% demo:
% color boundary detection with oriented Double-opponent cells.
% paper in CVPR 2013:
% Kaifu Yang, Shaobing Gao, Chaoyi Li, and Yongjie Li*.
% Efficient Color Boundary Detection with Color-opponent Mechanisms. CVPR, 2013.
% Website: http://www.neuro.uestc.edu.cn/vccl/home.html

% Kaifu Yang <yang_kf@163.com>
% March 2013
%=========================================================================%

clc;  clear;

% parameters setting
angles = 8;
sigma = 1.5;
weights = -0.6;

% read original image
map = double(imread('69020.jpg'))./255;
figure;imshow(map,[]);

tic
CO = COBoundary(map,sigma,angles,weights);
toc

figure;imshow(CO,[]);

fprintf(2,'======== THE END ========\n');
%=========================================================================%
