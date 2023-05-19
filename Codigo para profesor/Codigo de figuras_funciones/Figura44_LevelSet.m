%Prueba de level set
%Reconstrucción 3D
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('Directorio del estudio',1,1,1);
%Cálculo de g inicial
sigma=1.5;
G=fspecial('gaussian',15,sigma);
Img_smooth=conv2(img2,G,'same');
[Ix,Iy]=gradient(Img_smooth);
f=Ix.^2+Iy.^2;
g=1./(1+f);
%Aplicación de Level set
imagenLS=drlse_edge(img2, g, 15, 0.1, -3, 1, 0.6, 10,'single-well');
%Visualización
figure,imshow(imagenLS);