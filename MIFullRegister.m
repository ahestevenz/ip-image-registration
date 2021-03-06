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

%% Functions
addpath(genpath('functions/'))

%% Parameters
step_angle=0.5;
angle=-45:step_angle:45;
step_pixel=1;

%% Plot Parameters
plot_registered_images=false;

%% Getting DICOM images
patient=005;
[moving_16bit,fixed_16bit]=dicomIJDOpen(patient);

%% Convert to 8bit
moving_8bit=im2uint8(moving_16bit);
fixed_8bit=im2uint8(fixed_16bit);

%% MATLAB Image Registration (IP Toolbox)
[movingReg_16bit, optimizer, metric] = imgRegister(moving_16bit, fixed_16bit, -1, -1, -1, -1, -1, -1, -1, 'affine');
movingReg_8bit=im2uint8(movingReg_16bit);
disp(optimizer)
disp(metric)

%% Image Registration Mutual Information
tic
[h, h_max_value,movingMIReg, theta,dx,dy] = getFullMIRegistration(fixed_8bit,moving_8bit,angle,step_pixel);
elapsed_time=toc;


%% Graphics

if (plot_registered_images)
    figure('Name',['Patient ' num2str(patient) ': Unregistered images (16bit)']);
    imshowpair(moving_16bit,fixed_16bit);
    figure('Name',['Patient ' num2str(patient) ': Unregistered images (8bit)']);
    imshowpair(moving_8bit,fixed_8bit);
    figure('Name',['Patient ' num2str(patient) ': Registered images with IP Toolbox (8bit)']);
    imshowpair(movingReg_8bit,fixed_8bit);
    figure('Name',['Patient ' num2str(patient) ': Registered images with Mutual Information (8bit)']);
    imshowpair(movingMIReg,fixed_8bit);
    figure('Name',['Patient ' num2str(patient) ': Comparison between two registrations (8bit)']);
    imshowpair(movingMIReg,movingReg_8bit);
end

%% Save all matrices
save(['output/image_registration_patient_' num2str(patient) '_step_pixel_' num2str(step_pixel) '_step_angle_' num2str(step_angle) '_elapsed_time_' num2str(elapsed_time) '_seconds_mi_get_full_matrix.mat']);
