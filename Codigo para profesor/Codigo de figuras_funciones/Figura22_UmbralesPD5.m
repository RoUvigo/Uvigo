%Reconstrucción 3D
[img,ResX,ResY,ResZ,hist3D]=Reconstruye3D('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Otros\Abdomen\series-000001',4,0,0);

%Obtencion de umbrales%
tic
[Umbs,picos]=CalculaUmbralesPD5(hist3D,4,1);
toc

%Visulaización
Vision3D(img,Umbs(1)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(2)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(3)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(4)/256,ResX,ResY,ResZ);