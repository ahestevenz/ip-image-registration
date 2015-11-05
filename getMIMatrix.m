function hij = getMIMatrix(image_1,image_2, mv_rows, mv_cols, step)

im1=image_1;
hij=zeros(mv_rows,mv_cols);

for i=1:step:mv_rows
    for j=1:step:mv_cols
        im2=imtranslate(image_2,[j,i]);         
        hij(i,j)=MI_GG(im2,im1);
    end
end

end
