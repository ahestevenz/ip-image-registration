function [h_for, h_accu]=getJointHistogram
%% Joint Histogram calculation comparison

%% For loop
fixed_rgb=imread('/home/ahestevenz/IP/work/apImageRegister/build/ct.jpg');
moving_128_rgb=imread('/home/ahestevenz/IP/work/apImageRegister/build/pet.jpg');
moving_rgb=imresize(moving_128_rgb,4);

fixed=rgb2gray(fixed_rgb);
moving=rgb2gray(moving_rgb);

height=size(fixed,1);
width=size(fixed,2);
N=256;
h_for=zeros(N,N);

for i=1:height;
  for j=1:width;
    h_for(fixed(i,j)+1,moving(i,j)+1)= h_for(fixed(i,j)+1,moving(i,j)+1)+1;
  end
end

%% Another way
fixed = double(fixed);
moving = double(moving);

fixed_norm = fixed; 
moving_norm = moving;

FM_mat(:,1) = fixed_norm(:);
FM_mat(:,2) = moving_norm(:);
h_accu = accumarray(FM_mat+1, 1); 

