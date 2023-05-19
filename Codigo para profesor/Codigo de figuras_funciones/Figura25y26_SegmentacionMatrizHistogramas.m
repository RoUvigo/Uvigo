%Reconstrucción 3D
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D1('C:\Users\gdaf\Desktop\Fractura_Cervical\Probar\1.2.826.0.1.3680043.120_recortada',1,0,0);

%Calculo de umbrales y visualizacuión de histogramas
[Umbs,picos]=UmbralesConjuntoPD2(matrizhist3D,5);

%Representación tridimensional
Vision3D(img,Umbs(1)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(2)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(3)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(4)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(5)/256,ResX,ResY,ResZ);
