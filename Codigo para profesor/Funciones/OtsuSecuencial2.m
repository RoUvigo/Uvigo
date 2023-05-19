function umbs = OtsuSecuencial2(h0,N)

L = length(h0);

umbrales=[];
umbrales=[umbrales otsuthresh(h0)*255];
histmax=[0];

%
% Comenzamos a buscar umbarles en los espacios mas grandes
%

for i=2:N
    for j=1:length(umbrales)+1
        if j==1
            histact=h0(1:umbrales(j)-1);
            umbant=1;
        elseif j==length(umbrales)+1
            histact=h0(umbrales(j-1):L);
            umbant=umbrales(j-1);
        else
            histact=h0(umbrales(j-1):umbrales(j)-1);
            umbant=umbrales(j-1);
        end
        if length(histact)>length(histmax)
            histmax=histact;
            umbantmax=umbant;
        end
    end
    nuevo=otsuthresh(histmax);
    umbrales=[umbrales (nuevo)*(length(histmax)-1) + umbantmax]; %Se guarda el nuevo umbral
    umbrales=sort(umbrales); %ordenamos para que funcione adecuadamente
    histmax=[];
end
umbs=umbrales;





