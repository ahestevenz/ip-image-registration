%% Close all windows and delete all variables and matrices
close all
clear

%% Read images
fixed=imread('../../info/samples/crystal_grid.jpg');
moving=imread('../../info/samples/crystal_grid_rotate_10.jpg');
fixed=rgb2gray(fixed);
moving=rgb2gray(moving);


%% Affine transformation

% T=[ cos(pi/8) sin(pi/8) 0
%     -sin(pi/8) cos(pi/8) 0
%    40 40 1 ];
% 
% Rcb = imref2d(size(fixed));
% tform = affine2d(T);
% 
% Rout = Rcb;
% Rout.XWorldLimits(2) = Rout.XWorldLimits(2)+20;
% Rout.YWorldLimits(2) = Rout.YWorldLimits(2)+20;
% 
% 
%  
% [out,Rout] = imwarp(fixed,tform);
% figure;imshow(fixed,Rcb);
% figure;imshow(out,Rout);

%% 
figure;imshow(fixed);
figure;imshow(moving);
figure,imshowpair(moving,fixed);

[moving_reg, optimizer, metric] = imgRegister(moving, fixed, -1, -1, -1, -1, -1, -1, -1, 'affine');
[moving_reg_simil, optimizer, metric] = imgRegister(moving, fixed, -1, -1, -1, -1, -1, -1, -1, 'similarity');
figure,imshowpair(moving_reg,fixed);
figure,imshowpair(moving_reg_simil,fixed);
