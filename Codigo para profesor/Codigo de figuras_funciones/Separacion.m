function SFseparada=Separacion(img,umbral,ResX,ResY,ResZ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% Función de segmentación de tejidos en un umbral %
% %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cálculo de los ejes
[y0,x0,z0]=size(img);
x=(0:1:x0-1)*ResX;
y=(0:1:y0-1)*ResY;
z=(0:1:z0-1)*ResZ;
% Cálculo de la isosuperficie con la que se va a trabajar y representación
fprintf('Realizando la representacion sín separar...');
[SF.faces,SF.vertices]=isosurface(x,y,z,img,umbral/256);
figure, view(3), patch(SF,'facecolor','b','EdgeColor','none'), title('Representación 3D sin separar'),daspect([1 1 1]),camlight, lighting phong;
fprintf('Representación hecha. \n');
% Separado de la imagen 3D
SFseparada = splitFV4(SF); %Versión propia de la función de segmentación
%Representación de todas las estructuras separadas en una misma figura
colours = lines(length(SFseparada)); %Paleta de colores para diferentes tejidos
figure, view(3), hold on, title('Resultado separado'); %Preparo la representación
for i=1:length(SFseparada)
patch(SFseparada(i),'facecolor',colours(i,:),'EdgeColor','none')
end
daspect([1 1 1]),camlight, lighting phong;