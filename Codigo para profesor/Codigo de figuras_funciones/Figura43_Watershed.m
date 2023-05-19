%Ejecutable watershed
%Reconstrucción 3D
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Resonancia\Brain-Tumor-Progression\PGBM-001\04-02-1992-FH-HEADBrain Protocols-79896\11.000000-T1post-80644',1,1,1);
%Aplicación del filtro
imgcorregida = imdiffusefilt(img, 'NumberOfIterations' ,5);
%Limitamos algo para evitar sobresegmentacion
imgcorregida(imgcorregida>0.90)=1;
imgcorregida(imgcorregida<0.15)=0;
%Aplicación de watershed
imgWS=watershed(imgcorregida(:,:,18),4);
%Visualización
figure,imshow(imgWS);
