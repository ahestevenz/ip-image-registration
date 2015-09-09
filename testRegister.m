% La lista de estudios disponibles es:
%        000: Training 000
%        001: Patient 001
%        002: Patient 002
%        005: Patient 005
%        006: Patient 006
%        007: Patient 007

%% Close all windows and delete all variables and matrices
close all
clear all

%% Getting DICOM images
patient=007;
[moving,fixed]=dicomOpen(patient);
moving_resize=imresize(moving,4); % Resize moving image

% Graphics
figure('Name',['Patient ' num2str(patient) ': Unregistered images']);
imshowpair(moving_resize,fixed, 'montage');
figure('Name',['Patient ' num2str(patient) ': Unregistered images']);
imshowpair(moving_resize,fixed);

%% Registration
%[moving, fixed, optimizer, metric] = imgRegister(moving, fixed, growthfactor, epsilon, initialradius, iterations, samples, histogrambins, pixels, type)
[movingRegDefault, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, -1, -1, -1, -1, -1, 'affine');
figure('Name',['Patient ' num2str(patient) ': Default registration on affine transformation model']);
imshowpair(movingRegDefault, fixed);
disp('1: Default registration on affine transformation model')
disp(optimizer)
disp(metric)
pause

[movingRegRadius, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, optimizer.InitialRadius/10, -1, -1, -1, -1, 'affine');
figure('Name',['Patient ' num2str(patient) ': Registration with 1/10 default InitialRadius']);
imshowpair(movingRegRadius, fixed);
disp(' ')
disp('2: Registration with 1/10 default InitialRadius')
disp(optimizer)
disp(metric)
pause

[movingRegIter, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, -1, 10, -1, -1, -1, 'affine');
figure('Name',['Patient ' num2str(patient) ': Registration with 10 iterations']);
imshowpair(movingRegIter, fixed);
disp(' ')
disp('3: Registration with 10 iterations')
disp(optimizer)
disp(metric)
pause

[movingRegBins, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, -1, -1, -1, 10, -1, 'affine');
figure('Name',['Patient ' num2str(patient) ': Registration with 10 bins']);
imshowpair(movingRegBins, fixed);
disp(' ')
disp('4: Registration with 10 bins')
disp(optimizer)
disp(metric)
pause

%OJO

tformSimilarity = imregtform(moving_resize,fixed,'similarity',optimizer,metric);
Rfixed = imref2d(size(fixed));

movingRegisteredRigid = imwarp(moving_resize,tformSimilarity,'OutputView',Rfixed); 
[movingRegSimil, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, -1, -1, -1, -1, -1, 'similarity');
figure('Name',['Patient ' num2str(patient) ': Registration based on similarity transformation model']);
imshowpair(movingRegSimil, fixed);
disp(' ')
disp('5: Registration based on similarity transformation model')
disp(optimizer)
disp(metric)

% movingRegisteredDefault = imregister(moving_resize, fixed, 'affine', optimizer, metric);
% 
% figure, imshowpair(movingRegisteredDefault, fixed)
% title('A: Default registration')
% disp(optimizer)
% disp(metric)
% 
% optimizer.InitialRadius = optimizer.InitialRadius/3.5;
% 
% movingRegisteredAdjustedInitialRadius = imregister(moving_resize, fixed, 'affine', optimizer,metric);
% figure, imshowpair(movingRegisteredAdjustedInitialRadius, fixed)
% title('Adjusted InitialRadius')
% 
% optimizer.MaximumIterations = 300;
% movingRegisteredAdjustedInitialRadius300 = imregister(moving_resize, fixed, 'affine', optimizer,metric);
% figure, imshowpair(movingRegisteredAdjustedInitialRadius300, fixed)
% title('B: Adjusted InitialRadius, MaximumIterations = 300, Adjusted InitialRadius.')
% 
% tformSimilarity = imregtform(moving_resize,fixed,'similarity',optimizer,metric);
% Rfixed = imref2d(size(fixed));
% movingRegisteredRigid = imwarp(moving_resize,tformSimilarity,'OutputView',Rfixed);
% figure, imshowpair(movingRegisteredRigid, fixed);
% title('C: Registration based on similarity transformation model.');
% tformSimilarity.T
% 
% movingRegisteredAffineWithIC = imregister(moving_resize,fixed,'affine',optimizer,metric,...
% 'InitialTransformation',tformSimilarity);
% figure, imshowpair(movingRegisteredAffineWithIC,fixed);
% title('D: Registration from affine model based on similarity initial condition.');
