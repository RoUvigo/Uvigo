%Representacion de diferencia de tonalidades
%Reconstrucción 3D
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Otros\Abdomen\series-000001',4,0,1);
%Obtencion de las dos partes del estudio
imagenMetalico = img(:,:,30);
imagenNormal = img(:,:,80);
%Representacion
figura9 = [imagenMetalico imagenNormal];
figure;
imshow(figura9)