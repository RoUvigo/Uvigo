%Ejecutable region growing
%Reconstrucción 3D
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\Usuario\Desktop\Universidad\4_Curso\2_Cuatrimestre\TFG\Codigos matlab\Archivos dicom\Resonancia\Brain-Tumor-Progression\PGBM-001\04-02-1992-FH-HEADBrain Protocols-79896\11.000000-T1post-80644',1,1,1);
%Segmentación
J=regiongrowing(img(:,:,18),140,100,0.08);
%Visualización
figure,imshow(img(:,:,18));
figure,imshow(J);
