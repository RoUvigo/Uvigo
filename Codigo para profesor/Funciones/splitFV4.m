function fvOut2Ordenado = splitFV4( f, v )
%SPLITFV Splits faces and vertices into connected pieces
%   FVOUT = SPLITFV(F,V) separates disconnected pieces inside a patch defined by faces (F) and
%   vertices (V). FVOUT is a structure array with fields "faces" and "vertices". Each element of
%   this array indicates a separately connected patch.
%
%   FVOUT = SPLITFV(FV) takes in FV as a structure with fields "faces" and "vertices"
%
%   For example:
%     fullpatch.vertices = [2 4; 2 8; 8 4; 8 0; 0 4; 2 6; 2 2; 4 2; 4 0; 5 2; 5 0];
%     fullpatch.faces = [1 2 3; 1 3 4; 5 6 1; 7 8 9; 11 10 4];
%     figure, subplot(2,1,1), patch(fullpatch,'facecolor','r'), title('Unsplit mesh');
%     splitpatch = splitFV(fullpatch);
%     colours = lines(length(splitpatch));
%     subplot(2,1,2), hold on, title('Split mesh');
%     for i=1:length(splitpatch)
%         patch(splitpatch(i),'facecolor',colours(i,:));
%     end
%
%   Note: faces and vertices should be defined such that faces sharing a coincident vertex reference
%   the same vertex number, rather than having a separate vertice defined for each face (yet at the
%   same vertex location). In other words, running the following command: size(unique(v,'rows') ==
%   size(v) should return TRUE. An explicit test for this has not been included in this function so
%   as to allow for the deliberate splitting of a mesh at a given location by simply duplicating
%   those vertices.
%
%   See also PATCH

%   Copyright Sven Holcombe
%   $Date: 2010/05/19 $

%% Extract f and v
if nargin==1 && isstruct(f) && all(isfield(f,{'faces','vertices'}))
    v = f.vertices;
    f = f.faces;
elseif nargin==2
    % f and v are already defined
else
    error('splitFV:badArgs','splitFV takes a faces/vertices structure, or these fields passed individually')
end

%% Organise faces into connected fSets that share nodes
fSets = zeros(size(f,1),1,'uint32'); %Obtiene el numero de ceros como filas tengan las caras, lo pone en columna
currentSet = 0;
NumeroCaras=[]; % Genero una matriz en la que guardaré el numero de caras

while any(fSets==0) %Hasta que todos dejen de ser 0
    currentSet = currentSet + 1;
    fprintf('Connecting set #%d vertices...',currentSet);
    nextAvailFace = find(fSets==0,1,'first');%Busca el valor 0 que esta a continuación
    openVertices = f(nextAvailFace,:); %Coge los valores en esa posicion de la cara (el numero de vertice al que esta unida)
    while ~isempty(openVertices) %Mientras no este vacio openVertices
        availFaceInds = find(fSets==0); %Busca los valores que son 0 en fset que significan caras que no han sido usadas (creo)
        [availFaceSub, ~] = find(ismember(f(availFaceInds,:), openVertices)); %Busca en las caras que se encuentran disponibles los vertices que coinciden con la cara registrada en (openVertices) y guarda sus posiciones (la fila para saber que caras tienen esos vertices compartidos)
        fSets(availFaceInds(availFaceSub)) = currentSet; %A las caras que fueron seleccionadas les da el valor segun a donde se le asignen que se guardan en fset quitando el 0
        openVertices = f(availFaceInds(availFaceSub),:); %Coge como vertices todas las de las caras cogidas hasta ahora que pertenezcan a este objeto, para encontrar nuevas caras que unir en el bucle
    end
    fprintf(' done! Set #%d has %d faces.\n',currentSet,nnz(fSets==currentSet)); %Aqui solo comenta las caras que encontro (nnz(...) busca los valores que coinciden en la matriz con un numero)
    NumeroCaras=[NumeroCaras nnz(fSets==currentSet)]; %Posible mejora en la eficiencia temporal
end
numSets = currentSet; %Guarda el numero de caras que se han encontrado en todo el proceso.
%% Contar el numero de estructuras mayores a 1000
Booleano=NumeroCaras>1000; % Creamos una nueva matriz que este a 0 o a 1 si cumple la condición
Numeromayor1000=sum(Booleano); % Sumamos los 1
%% Eliminar caras que no son de utilidad para despues ordenar
CarasMayores=NumeroCaras.*Booleano; % Para hacer que solo queden los que son mayores de 1000 y el resto 0
CarasMayores(CarasMayores==0)=[]; % Para eliminar los 0
%% Create separate faces/vertices structures for each fSet
fvOut2 = repmat(struct('faces',[],'vertices',[]),Numeromayor1000,1); %Genera tantas estructuras con caras y vertices como superficies separadas se hayan encontrado.
contador=0;

for currentSet = 1:numSets
    setF = f(fSets==currentSet,:); %Selecciona las caras segun la superficie en la que se encuentren (selecciona las nuevas superficies desde la primera a la última)
    if (size(setF,1)>1000) % El objetivo de esta parte es asegurarse que solo pasan los tejidos con suficiente caras, y no representar ruido
        contador=contador+1;
        [unqVertIds, ~, newVertIndices] = unique(setF); %Ordena y pone por oden los diferentes vertices de la superficie anterior (unqVertIds), mientras que newVertIndices pone la matriz anterior (la de las caras con los vertices que la unen)
        fvOut2(contador).faces = reshape(newVertIndices,size(setF)); %Remodela newVertIndices para que sea la matriz setF (o eso parece)
        fvOut2(contador).vertices = v(unqVertIds,:); %Como tenemos los valores que hay en setF de manera ordenada, buscamos estos en los vectores y ya tenemos los que componen la nueva superficie
    end
end

%% Ordenar la matriz de salida - Acabar
fvOut2Ordenado = repmat(struct('faces',[],'vertices',[]),Numeromayor1000,1);
NumeroCarasOrdenadas = sort(CarasMayores,'descend');
x=1;
for i = 1:Numeromayor1000
    indice = find(ismember(CarasMayores,NumeroCarasOrdenadas(1)));
    if length(indice)>1 
        fvOut2Ordenado(i) = fvOut2(indice(x));
        x=x+1;
    else
        x=1;
        fvOut2Ordenado(i) = fvOut2(indice(x));
    end
    NumeroCarasOrdenadas(1) = [];
end