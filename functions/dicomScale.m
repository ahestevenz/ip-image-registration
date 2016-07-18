function dicomScale(img_dcm_path, scale)
%% dicomScale
% Función que realiza un reescalamiento de imágenes médicas en formato DICOM.
% dicomScale(img_dcm, scale)
%  img_dcm: ruta de la imagen 
%  scale: tamaño de la escala que se desea transformar


disp('Opening...')
img = dicomread(img_dcm_path);
disp('Scaling...')
img_scale=imresize(img,scale,'bilinear');
disp('To DICOM...')
[pathstr,name,ext] = fileparts(img_dcm_path);
dicomwrite(img_scale,fullfile(pathstr,[name '_scale' ext]));   