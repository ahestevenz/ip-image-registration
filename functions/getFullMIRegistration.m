function [h, h_max_value,image_Reg, theta,index_dx,index_dy] = getFullMIRegistration(image_1,image_2, angle, step)

[rows,cols]=size(image_2);
angle_cols=size(angle,2);
h=zeros(rows,cols,angle_cols);

im1=image_1;
im2=image_2;

% Get the mutual information matrix
parfor k=1:angle_cols
    im2_rot = imrotate(im2, angle(k),'bilinear','crop'); % Rotate and crop IMAGE2 
    h(:,:,k)=getFullMIMatrix(im1,im2_rot, rows, cols, step);
end

[h_max_value, h_index] = max(h(:));
[index_dy,index_dx,angle_index] = ind2sub(size(h),h_index);
theta=angle(angle_index);

% Rotate and translate with the MI maximal value
image_rot = imrotate(image_2,theta,'bilinear','crop');
idx1 = (image_rot<min(image_2(:)));
image_rot(idx1)=min(image_2(:));
image_Reg = imtranslate(image_rot,[index_dx, index_dy],'FillValues',min(image_2(:)));

end
