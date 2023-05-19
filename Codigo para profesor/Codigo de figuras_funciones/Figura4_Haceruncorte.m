%Representacion de un corte%
%Obtenemos información de la imagen
info=dicominfo('C:\Users\gdaf\Desktop\Fractura_Cervical\Práctica\Google-Drive\Tema2-T1-DENTAL\DENTAL\panoramica_dental_tac\IM-0001-0058.dcm'); 
NumBits=double(info.BitDepth)
%Representamos el corte en los niveles de gris adecuados
corte=double(dicomread('C:\Users\gdaf\Desktop\Fractura_Cervical\Práctica\Google-Drive\Tema2-T1-DENTAL\DENTAL\panoramica_dental_tac\IM-0001-0058.dcm'))/2^NumBits;
figure;
imshow(corte)
title('Representacion de 1 corte')

%Histograma
figure;
imhist(corte);
title('Histograma del corte')

%Segmentación del tejido%
%Segmentacion por binarización%
corte1 = imbinarize(corte,0.1);
corte2 = imbinarize(corte,0.4);
%Juntarlos y representarlo
segmentacion=[corte corte1 corte2];
figure;
imshow(segmentacion)
title('Corte segmentado');

% corte=double(dicomread('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Resonancia\ADNI4-DICOM-nano-10514\002_S_0413\Axial_3TE_T2_STAR\2019-08-27_09_39_37.0\S868724\ADNI_002_S_0413_MR_Axial_3TE_T2_STAR__br_raw_20190828115127287_67_S868724_I1221049.dcm'))/2^NumBits;
% imshow(corte)