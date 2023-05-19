%Reconstrucción 3D
[img,ResX,ResY,ResZ,hist3D]=Reconstruye3D2('C:\Users\gdaf\Desktop\Fractura_Cervical\Probar\1.2.826.0.1.3680043.10678',4,0,0);

%El sistema de segmentacion
tic
Umbs=OtsuSecuencial2(hist3D,5);
toc
%Visualización
Vision3D(img,Umbs(1)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(2)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(3)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(4)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(5)/256,ResX,ResY,ResZ);