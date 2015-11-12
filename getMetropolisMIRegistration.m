function [ moving_final, P, mi] = getMetropolisMIRegistration(fixed, moving)
%GETMETROPOLISMIREGISTRATION Summary of this function goes here
%   Detailed explanation goes here

%% Functions
addpath(genpath('Functions/'))

%% Get Initial Mutual Information
MI_0=MI(fixed,moving,'s');

%% Metropolis algorithm

MI_test=MI_0;
iterations=10000;
th_accept=0.5;
tx_accept=0;
ty_accept=0;

for i=1:iterations;
       
    th=normrnd(th_accept,2);% Parametro a sortear
    tx=normrnd(tx_accept,2);% Parametro a sortear
    ty=normrnd(ty_accept,2);% Parametro a sortear
    
    % Matrix transformation
    tform = [ cos(th) sin(th) 0
              -sin(th) cos(th) 0
              tx ty 1 ];
    t = affine2d(tform);
    
    % Rotate and translate
    moving_w = imwarp(moving,t,'OutputView',imref2d(size(moving)),'FillValues',255);
    
    % Current Mutual Information
    MI_curr = MI(fixed,moving_w,'s');
    
    % Check if it is better! 
      if (MI_curr > MI_test)
        th_accept=th;
        tx_accept=tx;
        ty_accept=ty;
        MI_test=MI_curr;                
      end    
end

%Rotate and translate with the MI maximal value
image_rot = imrotate(moving,th_accept,'bilinear','crop');
idx1 = (image_rot<min(moving(:)));
image_rot(idx1)=min(moving(:));
moving_final = imtranslate(image_rot,[tx_accept, ty_accept],'FillValues',min(moving(:)));
%%%
P = [th tx ty];
mi = MI_test;


end

