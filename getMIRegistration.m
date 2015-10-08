function [h, h_max_value,image_Reg, theta,dx,dy] = getMIRegistration(image_1,image_2, angle, step)

addpath(genpath('Functions/'))

[a,b]=size(angle);
[rows,cols]=size(image_2);
h=zeros(rows,cols,b);

im1=image_1;
im2=image_2;

%%GPU Implementation
%im1=gpuArray(image_1); 
%im2=gpuArray(image_2);

parfor k=1:b
    im2_rot = imrotate(im2, angle(k),'bilinear','crop'); %rotate and crop IMAGE2 
    %h(:,:,k) = MItranslate(image_1,image_2_rot, rows, cols, step)    
    h(:,:,k)=getMIMatrix(im1,im2_rot, rows, cols, step);
%     for i=1:step:rows
%         for j=1:step:cols
%             im2=imtranslate(image_2_rot,[j,i]);            
%             h(i,j,k)=MI_GG(im2,im1);
%         end
%     end
end

[h_max_value, h_index] = max(h(:));
[dy,dx,angle_index] = ind2sub(size(h),h_index);
theta=angle(angle_index);

%Rotate and translate
image_rot = imrotate(image_2,theta,'bilinear','crop');
for i=1:rows
    for j=1:cols
        if (image_rot(i,j)<min(image_2(:)))
        image_rot(i,j)=min(image_2(:));            
        end        
    end
end

image_Reg = imtranslate(image_rot,[dx, dy],'FillValues',min(image_2(:)));

end
