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
movig_mod=imrotate(moving,1);
% Gráficos
figure('Name', [ sample_directory, ' : Unregistered images']);
imshowpair(moving,fixed, 'montage');

%% Registración
%[movingReg, optimizer, metric, tformSimilarity] = imgTFormRegister(moving, fixed, growthfactor, epsilon, initialradius, iterations, samples, histogrambins, pixels, type)
[movingReg, optimizer, metric, tformSimilarity] = imgTFormRegister(moving, fixed, -1, -1, -1, -1, -1, -1, -1, 'rigid');
figure('Name',[ sample_directory, ' : Default registration on rigid transformation model']);
imshowpair(movingReg, fixed);
disp('Default registration on rigid transformation model')
disp(optimizer)
disp(metric)
tformSimilarity.T




