%Reconstrucción 3D
% [img,ResX,ResY,ResZ,hist3D]=Reconstruye3D1('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Otros\Abdomen\series-000001',4,0,0);
%Sistema de segmentación
Estructura=Separacion(img,67,ResX,ResY,ResZ); %Realiza la representacion todo junto en el programa
%Obtencion por separado de las 2 estructuras más grandes
figure;
patch(Estructura(1),'facecolor','b','EdgeColor','none'),daspect([1 1 1]),camlight, lighting phong;
figure;
patch(Estructura(2),'facecolor','r','EdgeColor','none'),daspect([1 1 1]),camlight, lighting phong; 
