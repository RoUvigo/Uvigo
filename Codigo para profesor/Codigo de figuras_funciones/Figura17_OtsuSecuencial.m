%Reconstrucción 3D
[img,ResX,ResY,ResZ,hist3D]=Reconstruye3D2('C:\Users\gdaf\Desktop\Fractura_Cervical\Práctica\Google-Drive\Tema2-T1-HEAD\HEAD\ANGIO-CT',4,0,0);

%LLamamos a la funcion encargada de segmentar
tic
Umbs=OtsuSecuencial3(hist3D);
toc

%Representamos los 3 umbrales
Vision3D(img,Umbs(1)/460,ResX,ResY,ResZ);
Vision3D(img,Umbs(2)/460,ResX,ResY,ResZ);
Vision3D(img,Umbs(3)/460,ResX,ResY,ResZ);