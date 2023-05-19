function [umbs,posf]=UmbralesConjuntoPD2(matrizhist3D,numero)
tam=size(matrizhist3D);
picos=[];
histogramas=[];
h1=zeros(1,256);
diferencia=0;
%Representación de histogramas y obtención de los picos de interés
for i=1:tam(2)
    nexttile;
    semilogy(matrizhist3D(:,i))
    [peaks,h] = CalculaUmbralesPD6(matrizhist3D(:,i),numero,1);
    picos =[picos, peaks];
    diferencia=length(h1)-length(h);
    h1=h1+[h,zeros(1,diferencia)];
end
%Obtención de los picos ordenados y el número de veces que aparecen
repetidos=[];
resultado=[];
while ~isempty(picos)
    ref=picos(1);
    zona=[picos(1)-4:picos(1)+4];
    indices=find(ismember(picos,zona));
    L=length(picos(indices));
    media=round(mean(picos(indices)));
    picos(indices)=[];
    resultado=[resultado media];
    repetidos=[repetidos L];
end
%Obtencion de picos más repetidos
desordenado=[repetidos;resultado];
[~,indice]=sort(desordenado(1,:),"descend");
ordenado=desordenado(:,indice);
ordenado=ordenado(2,:);
picos=ordenado(1:numero+1);

%A partir de aquí uso el final del sistema de detección de picos básico
posf = sort(picos); 
for i=1:length(posf)-1

    %Calculo del mínimo
    inicial = posf(i);
    final = posf(i+1);
    [~,aux2] = min(h1(inicial:final));
    minimo = inicial+aux2-1;
    umbs(i) = minimo;
end