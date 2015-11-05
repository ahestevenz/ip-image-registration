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

%% Parameters
angle=-45:5:45;
step=200;

%% Getting DICOM images
patient=007;
[moving_16bit,fixed_16bit]=dicomOpen(patient);
%moving_16bit=imresize(moving_original_16bit,4); % Resize moving image (http://www.mathworks.com/help/images/examples/registering-multimodal-3-d-medical-images.html)

%% Convert to 8bit
moving_8bit=im2uint8(moving_16bit);
fixed_8bit=im2uint8(fixed_16bit);

%% MATLAB Image Registration (IP Toolbox)
% [movingReg_16bit, optimizer, metric] = imgRegister(moving_16bit, fixed_16bit, -1, -1, -1, -1, -1, -1, -1, 'affine');
% figure('Name',['Patient ' num2str(patient) ': Default registration on affine transformation model (16bit)']);
% imshowpair(movingReg_16bit, fixed_16bit);
% movingReg_8bit=im2uint8(movingReg_16bit);
% disp('1: Default registration on affine transformation model')
% disp(optimizer)
% disp(metric)

%% Image Registration Mutual Information
[h, h_max_value,movingMIReg, theta,dx,dy] = getMIRegistration(fixed_8bit,moving_8bit,angle,step);


%% Graphics
 figure('Name',['Patient ' num2str(patient) ': Unregistered images (16bit)']);
 imshowpair(moving_16bit,fixed_16bit);
% figure('Name',['Patient ' num2str(patient) ': Unregistered images (8bit)']);
% imshowpair(moving_8bit,fixed_8bit);
% figure('Name',['Patient ' num2str(patient) ': Registered images with IP Toolbox (8bit)']);
% imshowpair(movingReg_8bit,fixed_8bit);
% figure('Name',['Patient ' num2str(patient) ': Registered images with Mutual Information (8bit)']);
% imshowpair(movingMIReg,fixed_8bit);
% figure('Name',['Patient ' num2str(patient) ': Comparison between two registrations (8bit)']);
% imshowpair(movingMIReg,movingReg_8bit);



