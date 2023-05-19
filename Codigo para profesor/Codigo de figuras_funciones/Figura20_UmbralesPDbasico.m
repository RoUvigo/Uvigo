%Reconstrucción 3D
[img,ResX,ResY,ResZ,hist3D]=Reconstruye3D1('C:\Users\gdaf\Desktop\Fractura_Cervical\Probar\1.2.826.0.1.3680043.10678',4,0,0);

%Obtencion de umbrales%
[Umbs,picos]=CalculaUmbralesPDBasico(hist3D,4)

%Visulaización
Vision3D(img,Umbs(1)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(2)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(3)/256,ResX,ResY,ResZ);
Vision3D(img,Umbs(4)/256,ResX,ResY,ResZ);