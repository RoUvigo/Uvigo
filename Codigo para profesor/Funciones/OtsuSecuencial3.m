function umbs = OtsuSecuencial3(h0)
%
% Otsu secuencial (solo 3 umbrales).
% 
L = length(h0);

ucentral = otsuthresh(h0)*(L-1);
hant = h0(1:ucentral-1);
hpost = h0(ucentral+1:L);
uant = otsuthresh(hant)*(length(hant)-1);
upost = ucentral + otsuthresh(hpost)*(length(hpost)-1);
umbs = [uant ucentral upost];