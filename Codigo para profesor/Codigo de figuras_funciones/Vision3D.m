function p=Vision3D(objeto3D,umbral,ResX,ResY,ResZ)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                           %
    % Función que crea la visión 3D.            %
    %                                           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    figure;
    %Esta primera parte definimos los vectores que posteriormente se emplearán 
    %para poner las medidas adecuadas en mm de los ejes 
    [y0,x0,z0]=size(objeto3D);
    x=(0:1:x0-1)*ResX;
    y=(0:1:y0-1)*ResY;
    z=(0:1:z0-1)*ResZ;


    p=patch(isosurface(x,y,z,objeto3D,umbral));
    %En el caso anterior la funcion isosurface genera una isosuperficie de un
    %volumen V con los ejes [x,y,z] y con un isovalor que en este caso
    %especifica la densidad de la superficie que queremos representar. Por otro
    %lado la función patch permite rellenar los pequeños huecos producidos por errores
    %de la función isosurface
    p.FaceColor = 'blue'; %Establece el color de las caras en la imagen
    p.EdgeColor = 'none'; %Establece el color de los bordes de la imagen
    daspect([1 1 1]) %Hace que las dimensiones de las variables X Y Z sean iguales de manera que se mantenga la proporción
    view(3) %Representamos el objeto creado anteriormente en 3D

    camlight; lighting phong; %Generar una luz interpolada buena para la representación de superficies curvas

end