%% Cierro ventanas y limpio variables y matrices
close all
clear

%% Localización de las imágenes
absolute_principal_path='/home/ahestevenz/IP/info/BNCT_Samples/';
sample_directory='Muestra_REF_17-10';

%% Funciones
addpath(genpath('functions/'))

%% Obtengo las imágenes BNCT
[moving, fixed]=imagesBNCTPairOpen(strcat(absolute_principal_path,'/',sample_directory));

% Gráficos
figure('Name', [ sample_directory, ' : Unregistered images']);
imshowpair(fixed, moving, 'montage');

%% Registración
disp('** Default registration on rigid transformation model')
%[movingReg, optimizer, metric, tformSimilarity] = imgTFormRegister(moving, fixed, growthfactor, epsilon, initialradius, iterations, samples, histogrambins, pixels, type)
[movingReg, optimizer, metric, tformRigid] = imgTFormRegister(moving, fixed, -1, -1, -1, -1, -1, -1, -1, 'rigid');
figure('Name',[ sample_directory, ' : Default registration on rigid transformation model']);
imshowpair(movingReg, fixed);
disp(optimizer)
disp(metric)

%% Datos de la registración
disp('** Transformation matrix parameters')
trasformation_matrix=tformRigid.T;
disp(trasformation_matrix)
angle=['Angulo de rotación: ',num2str(acos(trasformation_matrix(1)))];
dx=['Desplazamiento en X: ',num2str(trasformation_matrix(3))];
dy=['Desplazamiento en Y: ',num2str(trasformation_matrix(6))];
disp(angle)
disp(dx)
disp(dy)







