function [ moving_final, P, mi, th_vec, tx_vec, ty_vec,sx_vec, sy_vec, MI_vec, th_vec_a, tx_vec_a, ty_vec_a, sx_vec_a, sy_vec_a, MI_vec_a, MI_vec_derivative_a,MI_vec_accum_mean_a,MI_vec_accum_derivative_mean_a, iterations] = getMetropolisMIRegistration(fixed, moving, points)
%GETMETROPOLISMIREGISTRATION Summary of this function goes here
%   Detailed explanation goes here

%% Get Initial Mutual Information
MI_0=MI(fixed,moving,'s');

%% Metropolis algorithm

% Parameters
max_iterations=2500;

% Initial values
MI_test=MI_0;
th_accept=0.0175; % degtorad(1)
tx_accept=0;
ty_accept=0;
sx_accept=3;
sy_accept=3;

% Vectors
th_vec=[];
tx_vec=[];
ty_vec=[];
sx_vec=[];
sy_vec=[];
MI_vec=[];
th_vec_a=[];
tx_vec_a=[];
ty_vec_a=[];
sx_vec_a=[];
sy_vec_a=[];
MI_vec_a=[];
MI_vec_derivative_a=[];
MI_vec_accum_mean_a=[];

% Gaussian Window parameters
w_radians_a=-(pi/2)*10^-8; 
w_radians_b=pi/4;
w_pixels_a=-4*10^-8;
w_pixels_b=2;
w_scale_a=-6*10^-9;
w_scale_b=0.25;
i=1;
valid_points=1;

while (valid_points<points)
    if (i>max_iterations); break; end;
    
    th=normrnd(th_accept,w_radians_a*i+w_radians_b);% 
    tx=normrnd(tx_accept,w_pixels_a*i+w_pixels_b);% 
    ty=normrnd(ty_accept,w_pixels_a*i+w_pixels_b);% 
    sx=normrnd(sx_accept,w_scale_a*i+w_scale_b);%
    sy=normrnd(sy_accept,w_scale_a*i+w_scale_b);% 
    
    % Matrix transformation
    tform = [ sx*cos(th) sin(th) 0
              -sin(th) sy*cos(th) 0
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
    sx_vec(i)=sx;
    sy_vec(i)=sy;
    MI_vec(i)=MI_curr;
    th_vec_a(i)=th_accept;
    tx_vec_a(i)=tx_accept;
    ty_vec_a(i)=ty_accept;
    sx_vec_a(i)=sx_accept;
    sy_vec_a(i)=sy_accept;
    MI_vec_a(i)=MI_test;
    
    if (i>1) 
        MI_vec_accum_mean_a(i)= mean(MI_vec_a(1:i));
        MI_vec_derivative_a(i)=MI_vec_a(i)-MI_vec_a(i-1); 
        MI_vec_accum_derivative_mean_a(i)= mean(MI_vec_derivative_a(1:i));        
        if (MI_vec_accum_derivative_mean_a(i)<MI_vec_accum_derivative_mean_a(i-1))        
          valid_points=valid_points+1;          
        else
          valid_points=1;
        end       
    end        
        
    % Check if it is better! 
    if (MI_curr > MI_test)
      th_accept=th;
      tx_accept=tx;
      ty_accept=ty;
      sx_accept=sx;
      sy_accept=sy;
      MI_test=MI_curr;                
    end    
    i=i+1;
end

%% Rotate and translate with the MI maximal value
image_rot = imrotate(moving,radtodeg(th_accept),'bilinear','crop');
idx1 = (image_rot<min(moving(:)));
image_rot(idx1)=min(moving(:));
moving_final = imtranslate(image_rot,[tx_accept, ty_accept],'FillValues',min(moving(:)));


%% Final variables
P = [th_accept tx_accept ty_accept];
mi = MI_test;
iterations = i;


end

