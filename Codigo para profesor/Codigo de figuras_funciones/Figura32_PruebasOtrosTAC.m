%TAC de cabeza con segmentación
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Imagenes profesor\DENTAL\panoramica_dental_tac',2,0,0);

hist3D=imhist(img); 
semilogy(hist3D);

[Umbs,picos]=UmbralesConjuntoPD(matrizhist3D,3);

Separacion(img, Umbs(2), ResX,ResY,ResZ);

%%Tac de pelvis
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Tac\Hip',4,0,1);

hist3D=imhist(img);
figure,semilogy(hist3D);

[Umbs,picos]=CalculaUmbralesPD5(hist3D,6,1);

Vision3D(img,Umbs(5)/256,ResX,ResY,ResZ);



%TAC de rodilla
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Tac\Knee',2,1,1);

hist3D=imhist(img);
figure,semilogy(hist3D);

[Umbs,picos]=UmbralesConjuntoPD2(matrizhist3D,4);

Vision3D(img,Umbs(4)/256,ResX,ResY,ResZ);