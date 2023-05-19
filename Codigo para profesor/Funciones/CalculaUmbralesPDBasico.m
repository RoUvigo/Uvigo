function [umbs,peaks]=CalculaUmbralesPDBasico(h0,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                              %
%      Funcion que calcula umbrales seg´un peak detection.     %
%                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
low=min(find(h0>0));
high=max(find(h0>0));
nmax = N+1; %Se le suma uno porque los picos que se necesitan son uno mas que los umbrales
factor1 = 2;
factor2 = 0.5;
semiancho = round((high-low+1)/(factor1*2)); % Inicio - los que se tiene en cuenta para normalizar

%
% Buscar maximos
%
[valorm,posm] = max(h0);
while (length(posm)<nmax)
    %
    % Recorrer el histograma.
    %
    posm0 = [];
    valorm0 = [];
    for i=low:high
        valor = h0(i); % Valor actual
        index1 = max(low,i-semiancho);
        index2 = min(high,i+semiancho); % Limites
        entorno = h0(index1:index2);
        if (valor==max(entorno))
            posm0 = [posm0 i]; %Maximo encontrados con ese entorno
            valorm0 = [valorm0 valor];
        end
    end
    %
    % Ver si tengo suficientes maximos.
    %
    for i=1:length(posm0)
        [valor,j] = max(valorm0);%Guarda la posición y el valor maximo de los máximos que has registrado hasta ahora
        if (sum(valorm==valor)>0)
            % Si ya esta registrado, no lo metemos
            valorm0(j) = 0;
            continue;
        else
            % Guardarlo
            posm = [posm posm0(j)];
            valorm = [valorm valorm0(j)];
            valorm0(j) = 0; %Como ya se guardo para que deje de ser maximo
        end
        if (length(posm)==nmax)
            % Comprobacion
            break;
        end
    end
    %
    % Continuar con menor entorno.
    %
    semiancho = round(semiancho*factor2); %Reduce el semiancho para encontrar mas picos
end %Final del while
%
% Calcular umbrales.
%
posf = sort(posm); %Para ordenarlos
for i=1:length(posf)-1
    inicial = posf(i);
    final = posf(i+1);
    [~,aux2] = min(h0(inicial:final));
    minimo = inicial+aux2-1;
    umbs(i) = minimo; 
    peaks=posf;
end

