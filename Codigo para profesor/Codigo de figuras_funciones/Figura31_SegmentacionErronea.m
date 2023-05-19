%Reconstrucción 3D
[img,ResX,ResY,ResZ,hist3D]=Reconstruye3D('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Imagenes profesor\DENTAL\panoramica_dental_tac',2,0,0);
%Segmentación
Separacion(img,229,ResX,ResY,ResZ);