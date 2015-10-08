function hij = getMIMatrix(image_1,image_2, rows, cols, step)

im1=image_1;
hij=zeros(rows,cols);

for i=1:step:rows
    for j=1:step:cols
        im2=imtranslate(image_2,[j,i]); 
        %im2=image_2(i:(i+cols-1),j:(j+rows-1));
        hij(i,j)=MI_GG(im2,im1);
    end
end

end
