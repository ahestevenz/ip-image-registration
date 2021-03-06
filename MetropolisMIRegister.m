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
plot_metrics=true;
plot_registered_images=true;
fixed_translate=false;
dx_tr_fixed=10; % translate the fixed image in X axis (check the fixed_translate flag)
dy_tr_fixed=10; % translate the fixed image in Y axis (check the fixed_translate flag)

%% Getting DICOM images
patient=007;
[moving_16bit, fixed_16bit] = dicomIJDOpen(patient);

%% Translate the fixed image
if (fixed_translate)
    fixed_16bit=imtranslate(fixed_16bit,[dx_tr_fixed, dy_tr_fixed],'FillValues',min(fixed_16bit(:)));
end

%% Convert to 8bit
moving_8bit=im2uint8(moving_16bit);
fixed_8bit=im2uint8(fixed_16bit);

%% MATLAB Image Registration (IP Toolbox)
tic
[movingReg_16bit, optimizer, metric] = imgRegister(moving_16bit, fixed_16bit, -1, -1, -1, -1, -1, -1, -1, 'affine');
movingReg_8bit=im2uint8(movingReg_16bit);
disp(optimizer)
disp(metric)
elapsed_time_matlab=toc;

%% Image Registration Mutual Information
tic
[ movingMIReg, P, mi, th_vec, tx_vec, ty_vec, MI_vec, th_vec_a, tx_vec_a, ty_vec_a, MI_vec_a, iterations] = getMetropolisMIRegistration(fixed_8bit, moving_8bit, 250);
elapsed_time_metropolis=toc;

%% Metrics: Graphics

if (plot_metrics)
    % Accepted
    figure('Name',['Patient ' num2str(patient) ': Parameters accepted']);
    subplot(2,2,1)
    plot(th_vec_a)
    title('Angle of Rotation')

    subplot(2,2,2)
    plot(tx_vec_a)
    title('Translation in X axis')

    subplot(2,2,3)
    plot(ty_vec_a)
    title('Translation in Y axis')

    subplot(2,2,4)
    plot(MI_vec_a)
    title('Mutual Information')

    % All 
    figure('Name',['Patient ' num2str(patient) ': All parameters']);
    subplot(2,2,1)
    plot(th_vec)
    title('Angle of Rotation')

    subplot(2,2,2)
    plot(tx_vec)
    title('Translation in X axis')

    subplot(2,2,3)
    plot(ty_vec)
    title('Translation in Y axis')

    subplot(2,2,4)
    plot(MI_vec)
    title('Mutual Information')
end

%% Registration: Graphics

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
save(['output/image_registration_patient_' num2str(patient) '_iterations_' num2str(iterations) '_elapsed_time_' num2str(elapsed_time_metropolis) '_seconds_mi_metropolis_algorithm.mat']);
