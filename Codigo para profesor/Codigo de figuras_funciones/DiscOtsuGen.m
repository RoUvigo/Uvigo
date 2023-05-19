function D = DiscOtsuGen(hnorm,umbrales)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                %
%  Calcula el parametro D del Otsu generalizado  %
%                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = length(hnorm);
N = length(umbrales); % Inicio
for i=1:N+1,
    if (i==1) % Caracterizar las subdistribuciones
        d(i).distr = hnorm(1:umbrales(i)-1);
        d(i).index = [1:umbrales(i)-1];
    elseif (i==N+1)
        d(i).distr = hnorm(umbrales(i-1):L);
        d(i).index = [umbrales(i-1):L];
    else
        d(i).distr = hnorm(umbrales(i-1):umbrales(i)-1);
        d(i).index = [umbrales(i-1):umbrales(i)-1];
    end
    d(i).prob = sum(d(i).distr); % Probabilidad parcial
    if (d(i).prob>0) % Normalizar
        d(i).distr = d(i).distr/d(i).prob; 
    end
    d(i).med = sum(d(i).index(:).*d(i).distr(:)); 
end
%
% Media general.
%
med = 0;
for i=1:N+1,
    med = med + d(i).prob * d(i).med;
end
%
% Resulado final.
%
D = 0;
for i=1:N+1,
    D = D + d(i).prob * (med-d(i).med).^2;
end
