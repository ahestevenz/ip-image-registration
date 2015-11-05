function [h, h_max_value,image_Reg, theta,dx,dy] = getMIRegistration(image_1,image_2, angle, step)

addpath(genpath('Functions/'))
[rows,cols]=size(image_2);
mv_rows=rows/4;
mv_cols=cols/4;
angle_cols=size(angle,2);
h=zeros(mv_rows,mv_cols,angle_cols);

im1=image_1;
im2=image_2;

%%GPU Implementation
%im1=gpuArray(image_1); 
%im2=gpuArray(image_2);

parfor k=1:angle_cols
    im2_rot = imrotate(im2, angle(k),'bilinear','crop'); % Rotate and crop IMAGE2 
    h(:,:,k)=getMIMatrix(im1,im2_rot, mv_rows, mv_cols, step);
end

[h_max_value, h_index] = max(h(:));
[dy,dx,angle_index] = ind2sub(size(h),h_index);
theta=angle(angle_index);

%Rotate and translate with the MI maximal value
image_rot = imrotate(image_2,theta,'bilinear','crop');

%MASO! SOLO PARA RELLENAR
for i=1:rows
    for j=1:cols
        if (image_rot(i,j)<min(image_2(:)))
        image_rot(i,j)=min(image_2(:));            
        end        
    end
end
%%%

image_Reg = imtranslate(image_rot,[dx, dy],'FillValues',min(image_2(:)));

end
