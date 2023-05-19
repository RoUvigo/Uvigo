function [img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D3(directorio,fm,invertida,adaptar)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                           %
    % Función que recontruye en 3D.             %
    %                                           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %si invertida se pone a 1 es que está invertida
    hist3D=0;
    matrizhist3D=[];
    d0=pwd; %Para guardar el directorio de trabajo
    chdir(directorio); %Te envía al directorio donde está la imagen
    lista=dir('*.dcm'); %Crea una lista en la que se guarda información de cada archivo del directorio
    nlista=length(lista); %Número de archivos que hay en el directorio
    c=1; %inicializamos la variable c
    info=dicominfo(lista(1).name); %Veo la informacion del primer archivo almacenados
    NumBits=double(info.BitDepth); %El número de bits de la imagen
    contador=0;
    if invertida 
        for p=nlista-1:-fm:0
            filename=lista(nlista-p).name; %Coge el nombre de cada archivo de la lista
            imaux=double(dicomread(filename))/2^12; %lee todos los dicom con los diferentes nombres y los convierte en double
            %Si quieres adaptar los slices se realiza aqui-puede ser
            %contraproducente
            if adaptar
                M=max(imaux(:));
                m=min(imaux(:)); 
                imaux=(imaux-m)/(M-m); % Adapta los valores a todo el intervalo
            end

            hist3D=hist3D+imhist(imaux);
            img(:,:,c)=imaux; 
            c=c+1;

            %Para guardar con un intervalo de 10 los histogramas
            contador=contador+1;
            if contador==10
                matrizhist3D=[matrizhist3D hist3D];
                hist3D=0;
                contador=0;
            end

        end
    else
        for p=fm:fm:nlista-1
            filename=lista(nlista-p).name; %Coge el nombre de cada archivo de la lista
            imaux=double(dicomread(filename))/2^12;

            %Por si se requiere adaptar la señal entre 0 y 1
            if adaptar
                M=max(imaux(:));
                m=min(imaux(:)); 
                imaux=(imaux-m)/(M-m); % Adapta los valores a todo el intervalo
            end

            img(:,:,c)=imaux; %lee todos los dicom con los diferentes nombres y lo añade a la matriz en formato double
            hist3D=hist3D+imhist(imaux);
            c=c+1;

            %Para guardar con un intervalo de 10 los histogramas
            contador=contador+1;
            if contador==10
                matrizhist3D=[matrizhist3D hist3D];
                hist3D=0;
                contador=0;
            end

        end
    end
    chdir(d0); %Me permite volver al directorio del que partí
    
    %Cálculo de las resoluciones
    ResX=info.PixelSpacing(1);
    ResY=info.PixelSpacing(2); 
    
    %Para estimar la resolucion en el eje z
    if isfield(info,'SpacingBetweenSlices')
        ResZ = info.SpacingBetweenSlices*fm; %Leer la resolución en z
    elseif isfield(info,'SliceThickness')
        ResZ = (info.SliceThickness/2)*fm; %Leer la resolución en z
    else
        ResZ = (ResX+ResY)/2*fm;  %Estimarla
    end

end
