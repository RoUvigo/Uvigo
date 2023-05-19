function [peaks,h1]=CalculaUmbralesPD6(h0,N,tiponormalizacion)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                              %
%      Funcion que calcula umbrales seg´un peak detection.     %
%                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Este documento fue modificado para que en vez de priorizar picos más altos en el histograma normalizado que seleccione picos más altos en el original

low=min(find(h0>0));
high=max(find(h0>0));
nmax = N+1; %Se le suma uno porque los picos que se necesitan son uno mas que los umbrales
factor1 = 2;
factor2 = 0.5;
semiancho = round((high-low+1)/(factor1*2)); % Inicio - los que se tiene en cuenta para normalizar (empieza con 1/4 del ancho total)
%
% Normalizar histograma.
%
switch (tiponormalizacion)
case 1,
    semiancho1 = round(semiancho/2);
    for i=low:high,
        inicio = max(i-semiancho1,low);
        fin = min(i+semiancho1,high); %seleccionas el minimo que te interese
        aux = mean(h0(inicio:fin)); %Media
        if (aux>0)
            h1(i) = h0(i)/aux; %Divides el valor por la media de su contorno
        else
            h1(i) = 0;
        end
    end
case 2, 
    semiancho1 = round(semiancho/2);
    for i=low:high,
        inicio = max(i-semiancho1,low);
        fin = min(i+semiancho1,high);
        h1(i) = mean(h0(inicio:fin));
    end
otherwise,
    h1 = h0; %El valor de posición es la media de su entorno
end
%
% Buscar maximos
%
[valorm,posm] = max(h1); %Localiza el maximo absoluto y su valor
while (length(posm)<nmax & semiancho>=2),
    %
    % Recorrer el histograma.
    %
    posm0 = [];
    valorm0 = [];
    valorOr0 = [];
    for i=low:high,
        valor = h1(i); % Valor actual
        index1 = max(low,i-semiancho);
        index2 = min(high,i+semiancho); % Limites
        entorno = h1(index1:index2);
        
        index12 = max(low,i-4);
        index22 = min(high,i+4);
        entornoizq = h0(index12:i);
        entornoder = h0(i:index22);

        index13 = max(low,i-25);
        index23 = min(high,i+25);
        entorno3 = h1(index13:index23);

        indexcaida = min(high,i+8);
        entornocaida =  h0(i:indexcaida);

        if (valor==max(entorno) & (h0(i)>max(h0)/10000 & h0(i)>5*min(h0)) & ((h0(i)>1.20*min(entornoizq) & h0(i)>1.20*min(entornoder)) | h1(i)>=max(entorno3) | h0(i)>2.5*min(entornocaida)) & ~(2<i & i<10)) % Si el valor es la posicion máxima de su entorno lo guarda
            posm0 = [posm0 i]; % Posicion del máximo
            valorm0 = [valorm0 valor];% Valor máximo encontrados con ese entorno
            valorOr0 = [valorOr0 h0(i)];% Miramos a que corresponde en el original y lo añadimos
        end
    end
    %
    % Ver si tengo suficientes maximos.
    %
    for i=1:length(posm0),
        [~,j] = max(valorOr0); %Lo que queremos es ir cogiendo en orden los picos segun que su valor esté más alto en el histograma original
        valor = valorm0(j); %Coge el valor del pico en el normalizado
        if (sum(valorm == valor)>0) %Si el valor ya esta dentro se ejecuta lo de abajo
            % Si ya esta registrado, no lo metemos
            valorOr0(j) = 0; %Para que deje de ser el máximo
            continue;
        else
            % Guardarlo
            posm = [posm posm0(j)];
            valorm = [valorm valorm0(j)];
            valorOr0(j) = 0; %Como ya se guardo para que deje de ser maximo (el cambio lo hago en el original)
        end
        if (length(posm)==nmax) %Si tenemos suficientes salimos
            % Comprobacion
            break;
        end
    end
    %
    % Continuar con menor entorno.
    %
    semiancho = round(semiancho*factor2); %Reduce el semiancho para encontrar mas picos(O eso entiendo)
end %Final del while
%
% Calcular umbrales.
%
posf = sort(posm); %Para ordenarlos
peaks=posf;
