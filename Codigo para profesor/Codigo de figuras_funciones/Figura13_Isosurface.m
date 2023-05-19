%Generación de una isosuperficie
%Reconstruye 3D%
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D1('C:\Users\gdaf\Desktop\Fractura_Cervical\Probar\1.2.826.0.1.3680043.10678',4,0,0);
%Creación de los ejes
figure;
[x0,y0,z0]=size(img);
x=(0:1:x0-1)*ResX;
y=(0:1:y0-1)*ResY;
z=(0:1:z0-1)*ResZ;
%Representación
iso = isosurface(x,y,z,img,45/256)

%Funcion Patch%
patch(iso,'facecolor','blue','edgecolor','none'),daspect([1 1 1]),camlight, lighting phong;