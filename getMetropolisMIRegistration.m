function [ moving_final, P, mi, th_vec, tx_vec, ty_vec, MI_vec, th_vec_a, tx_vec_a, ty_vec_a, MI_vec_a] = getMetropolisMIRegistration(fixed, moving)
%GETMETROPOLISMIREGISTRATION Summary of this function goes here
%   Detailed explanation goes here

%% Functions
addpath(genpath('Functions/'))

%% Get Initial Mutual Information
MI_0=MI(fixed,moving,'s');

%% Metropolis algorithm

MI_test=MI_0;
iterations=5000;
th_accept=0.5;
tx_accept=0;
ty_accept=0;

% Vectors
th_vec=[];
tx_vec=[];
ty_vec=[];
MI_vec=[];
th_vec_a=[];
tx_vec_a=[];
ty_vec_a=[];
MI_vec_a=[];

for i=1:iterations;
       
    th=normrnd(th_accept,(-7.200000288000011*10^-8)*(i^2) + 2.000000072000003);% Parametro a sortear
    tx=normrnd(tx_accept,(-7.200000288000011*10^-8)*(i^2) + 2.000000072000003);% Parametro a sortear
    ty=normrnd(ty_accept,(-7.200000288000011*10^-8)*(i^2) + 2.000000072000003);% Parametro a sortear
    
    % Matrix transformation
    tform = [ cos(th) sin(th) 0
              -sin(th) cos(th) 0
              tx ty 1 ];
    t = affine2d(tform);
    
    % Rotate and translate
    moving_w = imwarp(moving,t,'OutputView',imref2d(size(moving)),'FillValues',255);
    
    % Current Mutual Information
    MI_curr = MI(fixed,moving_w,'s');
    
    % Vectors    
    th_vec(i)=th;
    tx_vec(i)=tx;
    ty_vec(i)=ty;
    MI_vec(i)=MI_curr;
    th_vec_a(i)=th_accept;
    tx_vec_a(i)=tx_accept;
    ty_vec_a(i)=ty_accept;
    MI_vec_a(i)=MI_test;
        
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
P = [th_accept tx_accept ty_accept];
mi = MI_test;


end

