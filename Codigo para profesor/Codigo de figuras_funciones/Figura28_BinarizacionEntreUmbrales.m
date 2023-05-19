%Reconstrucción 3D
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Otros\Abdomen\series-000001',4,0,0);
%Obtencion de umbrales
[Umbs,picos]=UmbralesConjuntoPD2(matrizhist3D,5);
%Segmentación entre umbrales
img2=Umbs(4)/256<=img & img<Umbs(5)/256;
img3=bwareaopen(img2,1000); %Para eliminar elementos de poco tamaño
%Visualización
Vision3D(img3,40/256,ResX,ResY,ResZ); %Serviria cualquier 'umbral'



