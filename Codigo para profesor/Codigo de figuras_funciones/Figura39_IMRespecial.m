%Representación otro tipo de IRM
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Resonancia\ADNI4-DICOM-nano-10514\003_S_1122\Axial_T2_STAR\2019-05-07_10_25_03.0\S821701',1,1,1);

imgcorregida = imdiffusefilt(img, 'NumberOfIterations' ,3);

hist3D=imhist(imgcorregida);

[Umbs,picos]=CalculaUmbralesPD5(hist3D,3,1);
Vision3D(img,Umbs(2)/256,ResX,ResY,ResZ);