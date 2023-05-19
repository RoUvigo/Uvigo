function umbs = UmbOtsuGen(h0,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                         %
%  Calcula el umbral de OTSU Generalizado %
%                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux = find(h0>0);
inicio = min(aux);
fin = max(aux);
h = h0(inicio:fin);
offset = inicio-1;
L = length(h);
hnorm = h/sum(h); % Inicio
%
% Buscar el vector de umbrales.
%
umbrales = 2:2:2*N;
limites = L-2*(N-1):2:L;
Dmax = 0;
umbmax = umbrales;
running = 1; % Inicio
while (running),
   D = DiscOtsuGen(hnorm,umbrales); % Valor actual
   if (D>Dmax) % Nuevo maximo provisional
      Dmax = D;
      umbmax = umbrales;
   end
   %
   % Hacer avanzar el vector de umbrales.
   % Lo que hace es ir recorriendo todos los posibles valores [1 1 1],[1,1,2],...,[1,2,1],[1,2,2].....
   %
   i = N;
   while(i>0),
      umbrales(i) = umbrales(i)+1;
      if (umbrales(i)<=limites(i)) % se ha incrementado bien
         for j=i+1:N,
            umbrales(j) = umbrales(j-1)+2;
         end
         break; % Ya avanzamos, salir del "while interno"
      elseif (i==1) % Acabamos
         running = 0;
         break;
      else % Pasar al umbral anterior
         i = i-1;
      end
   end
end 
%
% Resultado final.
%
umbs = offset+umbmax;
