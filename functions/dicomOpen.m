function [moving, fixed] = dicomOpen(patient)
%% dicomOpen
% Función que abre imágenes médicas en formato DICOM del repositorio
% Insight Journal. Solo se le debe pasar el número de paciente. Se debe
% tener en cuenta que solo se abren imágenes de PET y CT y no todos los
% pacientes tienen estos estudios.
%
% La lista de estudios disponibles es:
%         000: Training 000
%         001: Patient 001
%         002: Patient 002
%         005: Patient 005
%         006: Patient 006
%         007: Patient 007
%
% Cada uno de estos estudios están compuestos por una imagen en CT y otra en
% PET. 
%

addpath(genpath('../../info/DICOM_Samples/Insight_Journal/'));

switch patient
    case 000
        disp('Training 000')
        moving_128 = dicomread('training_001/pet/outDICOM/image001.dcm');
        moving=imresize(moving_128,4);
        fixed = dicomread('training_001/ct/outDICOM/image001.dcm');                
        
    case 001
        disp('Patient 001')
        moving_128 = dicomread('patient_001/pet/outDICOM/image001.dcm');
        moving=imresize(moving_128,4);
        fixed = dicomread('patient_001/ct/outDICOM/image001.dcm');                
        
    case 002
        disp('Patient 002')
        moving_128 = dicomread('patient_002/pet/outDICOM/image001.dcm');
        moving=imresize(moving_128,4);
        fixed = dicomread('patient_002/ct/outDICOM/image001.dcm');
        
    case 005
        disp('Patient 005')
        moving_128 = dicomread('patient_005/pet/outDICOM/image001.dcm');
        moving=imresize(moving_128,4);
        fixed = dicomread('patient_005/ct/outDICOM/image001.dcm');
        
    case 006
        disp('Patient 006')
        moving_128 = dicomread('patient_006/pet/outDICOM/image001.dcm');
        moving=imresize(moving_128,4);
        fixed = dicomread('patient_006/ct/outDICOM/image001.dcm');
    
    case 007
        disp('Patient 007')
        moving_128 = dicomread('patient_007/pet/outDICOM/image001.dcm');
        moving=imresize(moving_128,4);
        fixed = dicomread('patient_007/ct/outDICOM/image001.dcm');
        
    otherwise
        disp('Paciente no encontrado. La lista disponible es la siguiente: ')
        moving=NaN;
        fixed=NaN;
        disp('000: Training 000')
        disp('001: Patient 001')
        disp('002: Patient 002')
        disp('005: Patient 005')
        disp('006: Patient 006')
        disp('007: Patient 007')        
end

end
    