function [moving, fixed] = dicomVolumeOpen(patient)
%% dicomVolumeOpen
% Función que abre imágenes médicas en formato DICOM del repositorio
% Insight Journal. Solo se le debe pasar el número de paciente. Se debe
% tener en cuenta que solo se abren volumenes en 3D de PET y CT y no todos los
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
% Cada uno de estos estudios están compuestos por una volumen en CT y otro en
% PET. 
%

addpath(genpath('../../info/DICOM_Samples/Insight_Journal/'));
%clear

switch patient
    case 000
        disp('Training 000')
        for p=0:13
                filename = sprintf('training_001/pet/outDICOM/image%03d.dcm', p);
                moving_128=dicomread(filename); % Resize moving image
                moving(:,:,p+1) = imresize(moving_128,4);
        end
        for p=0:13
                filename = sprintf('training_001/ct/outDICOM/image%03d.dcm', 2*p);
                fixed(:,:,p+1) = dicomread(filename);
        end                
        
    case 001
        disp('Patient 001')
        for p=0:13
                filename = sprintf('patient_001/pet/outDICOM/image%03d.dcm', p);
                moving_128=dicomread(filename); % Resize moving image
                moving(:,:,p+1) = imresize(moving_128,4);
        end
        for p=0:13
                filename = sprintf('patient_001/ct/outDICOM/image%03d.dcm', 2*p);
                fixed(:,:,p+1) = dicomread(filename);
        end                
        
    case 002
        disp('Patient 002')
        for p=0:13
                filename = sprintf('patient_002/pet/outDICOM/image%03d.dcm', p);
                moving_128=dicomread(filename); % Resize moving image
                moving(:,:,p+1) = imresize(moving_128,4);
        end
        for p=0:13
                filename = sprintf('patient_002/ct/outDICOM/image%03d.dcm', 2*p);
                fixed(:,:,p+1) = dicomread(filename);
        end                
        
    case 005
        disp('Patient 005')
        for p=0:13
                filename = sprintf('patient_005/pet/outDICOM/image%03d.dcm', p);
                moving_128=dicomread(filename); % Resize moving image
                moving(:,:,p+1) = imresize(moving_128,4);
        end
        for p=0:13
                filename = sprintf('patient_005/ct/outDICOM/image%03d.dcm', 2*p);
                fixed(:,:,p+1) = dicomread(filename);
        end                
        
    case 006
        disp('Patient 006')
        for p=0:13
                filename = sprintf('patient_006/pet/outDICOM/image%03d.dcm', p);
                moving_128=dicomread(filename); % Resize moving image
                moving(:,:,p+1) = imresize(moving_128,4);
        end
        for p=0:13
                filename = sprintf('patient_006/ct/outDICOM/image%03d.dcm', 2*p);
                fixed(:,:,p+1) = dicomread(filename);
        end                
    
    case 007
        disp('Patient 007')
         for p=0:13
                filename = sprintf('patient_007/pet/outDICOM/image%03d.dcm', p);
                moving_128=dicomread(filename); % Resize moving image
                moving(:,:,p+1) = imresize(moving_128,4);
         end
         for p=0:13
                filename = sprintf('patient_007/ct/outDICOM/image%03d.dcm', 2*p);
                fixed(:,:,p+1) = dicomread(filename);
         end
        
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
