function [moving, fixed] = imagesBNCTPairOpen(path)
%% imagesBNCTPairOpen
% Función que abre imágenes médicas en formato TIFF correspondiente al proyecto
% BNCT del Centro Atómico Constituyentes (San Martín, Bs As). Solo se le debe 
% pasar la ruta donde se encuentras las imágenes histológicas y
% radiográficas.
% Se debe tener en cuenta que son tres histológicas y tres radigráficas
% obtenidas a partir del mismo sistema de referencia. Las coordenadas del
% punto izquierdo inferior de cada imagen son las siguientes:
%
% IMG 1: (0,0)
% IMG 2: (0,2400)
% IMG 3: (0,4800)
%
% De esta manera se compone la imagen final concatenando estas tres
% imágenes. 
% Estas imágenes deben estar dentro de un directorio con el código de la
% muestra con los siguientes nombres:
%
% Imágenes histológicas: h1.tif h2.tif h3.tif
% Imágenes radiológicas: r1.tif r2.tif r3.tif
%
% Esta función genera la imagen final fixed (compuesta por las tres
% imágenes histológicas) y la imagen final moving (compuesta por las tres
% imágenes radiológicas).
%


h1=imread(strcat(path,'/h1.tif'));
h2=imread(strcat(path,'/h2.tif'));
h3=imread(strcat(path,'/h3.tif'));

r1=imread(strcat(path,'/r1.tif'));
r2=imread(strcat(path,'/r2.tif'));
r3=imread(strcat(path,'/r3.tif'));

fixed=[h3;h2;h1];
moving=[r3;r2;r1];

end
    