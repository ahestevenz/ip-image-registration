function hij = getFullMIMatrix(image_1,image_2, rows, cols, step)

im1=image_1;
hij=zeros(rows,cols);

for i=1:step:rows
    for j=1:step:cols
        im2=imtranslate(image_2,[j,i]);         
        hij(i,j)=MI(im2,im1,'s');
    end
end

end