function dicomShow(fixed_dcm_path, moving_dcm_path, moving_reg_dcm_path)
%% dicomShow
% Función que muestra y compara imágenes médicas en formato DICOM. Esta función
% está pensada para comparar imágenes previamente registradas. Muestra dos
% gráficos correspondientes a imágenes médicas antes y después de ser
% registradas.
% dicomShow(fixed_dcm_path, moving_dcm_path, moving_reg_dcm_path)
%  fixed_dcm_path: ruta de la imagen anatómica (fixed) 
%  moving_dcm_path: ruta de la imagen metabólica (moving)
%  moving_reg_dcm_path: ruta de la imagen registrada

disp('Opening images ...')
image_fixed = dicomread(fixed_dcm_path);
image_moving = dicomread(moving_dcm_path);
image_moving_reg = dicomread(moving_reg_dcm_path);

[pathstr_fixed,name_fixed,ext] = fileparts(fixed_dcm_path);
[pathstr_moving,name_moving,ext] = fileparts(moving_dcm_path);
[pathstr_moving_reg,name_moving_reg,ext] = fileparts(moving_reg_dcm_path);

disp('Showing images ...')
figure('Name',['Unregistered images: ' name_fixed ' and ' name_moving ]);
imshowpair(image_fixed,image_moving);
figure('Name',['Registered images: ' name_fixed ' and ' name_moving_reg ]);
imshowpair(image_fixed,image_moving_reg);
end