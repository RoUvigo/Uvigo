%Representacion angiografía
%Reconstrucción 3D
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Imagenes profesor\ANGIO-CT-V2',3,1,0);
%Visualización de histograma
hist3D=imhist(img); 
semilogy(hist3D);
%Cálculo de umbrales
[Umbs,picos]=CalculaUmbralesPD5(hist3D,4,1);
%Visualización
Vision3D(img,83/256,ResX,ResY,ResZ);
