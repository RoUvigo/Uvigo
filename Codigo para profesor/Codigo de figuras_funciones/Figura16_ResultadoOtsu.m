%Reconstrucción 3D de la figura
[img,ResX,ResY,ResZ,hist3D]=Reconstruye3D2('C:\Users\gdaf\Desktop\Nuevas',4,0,0);
%Obtencion de umbrales
tic
umbsOtsu = UmbOtsuGen(hist3D,3);
toc
%Representacion estructuras
Vision3D(img,umbsOtsu(1)/269,ResX,ResY,ResZ);
Vision3D(img,umbsOtsu(2)/269,ResX,ResY,ResZ);
Vision3D(img,umbsOtsu(3)/269,ResX,ResY,ResZ);
