% La lista de estudios disponibles es:
%        000: Training 000
%        001: Patient 001
%        002: Patient 002
%        005: Patient 005
%        006: Patient 006
%        007: Patient 007

%% Close all windows and delete all variables and matrices
close all
clear

%% Getting DICOM images
patient=002;
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

[movingRegRadius, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, optimizer.InitialRadius/10, -1, -1, -1, -1, 'affine');
figure('Name',['Patient ' num2str(patient) ': Registration with 1/10 default InitialRadius']);
imshowpair(movingRegRadius, fixed);
disp(' ')
disp('2: Registration with 1/10 default InitialRadius')
disp(optimizer)
disp(metric)

[movingRegIter, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, -1, 10, -1, -1, -1, 'affine');
figure('Name',['Patient ' num2str(patient) ': Registration with 10 iterations']);
imshowpair(movingRegIter, fixed);
disp(' ')
disp('3: Registration with 10 iterations')
disp(optimizer)
disp(metric)

[movingRegBins, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, -1, -1, -1, 10, -1, 'affine');
figure('Name',['Patient ' num2str(patient) ': Registration with 10 bins']);
imshowpair(movingRegBins, fixed);
disp(' ')
disp('4: Registration with 10 bins')
disp(optimizer)
disp(metric)

[movingRegSimil, optimizer, metric] = imgRegister(moving_resize, fixed, -1, -1, -1, -1, -1, -1, -1, 'similarity');
figure('Name',['Patient ' num2str(patient) ': Registration based on similarity transformation model']);
imshowpair(movingRegSimil, fixed);
disp(' ')
disp('5: Registration based on similarity transformation model')
disp(optimizer)
disp(metric)

tformSimilarity = imregtform(moving_resize,fixed,'similarity',optimizer,metric); % get an initial transformation estimate based on a 'similarity' model (translation,rotation, and scale)
Rfixed = imref2d(size(fixed));
movingRegRigid = imwarp(moving_resize,tformSimilarity,'OutputView',Rfixed); % apply the geometric transformation output from imregtform to the moving image to align it with the fixed image 
figure('Name',['Patient ' num2str(patient) ': Registration based on similarity transformation model']);
imshowpair(movingRegRigid, fixed);
disp(' ')
disp('6: Registration based on similarity transformation model')
disp(optimizer)
disp(metric)

%The "T" property of the output geometric transformation defines the
%transformation matrix that maps points in moving to corresponding points in fixed.
movingRegAffineWithIC = imregister(moving_resize,fixed,'affine',optimizer,metric,'InitialTransformation',tformSimilarity);
%Using the 'InitialTransformation' to refine the 'similarity' result of imregtform with a
%full affine model has also yielded a nice registration result.
figure('Name',['Patient ' num2str(patient) ': Registration based on affine transformation model with initial conditions']);
imshowpair(movingRegSimil, fixed);
disp(' ')
disp('7: Registration based on affine transformation model with initial conditions')
disp(optimizer)
disp(metric)
tformSimilarity.T
